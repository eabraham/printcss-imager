class AccountController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
    if current_user.account
      @account = Account.find_by_user_id(current_user.id)
      customer = Stripe::Customer.retrieve(@account.customer_key)

      if customer.subscriptions.first
        @plan = customer.subscriptions.first.plan.name
      else
        @plan = ""
      end
    end
  end

  def create
    token, plan = params[:stripeToken], params[:plan]
    
    account = Account.find_or_create_by(user_id:current_user.id)

    if account.customer_key
  	  #update customer with new card
      customer = Stripe::Customer.retrieve(account.customer_key)
      customer.card = token
      customer.save
    else
      # Create a Customer and save token
      customer = Stripe::Customer.create(
        :card => token,
        :email => current_user.email
      )
      account.customer_key = customer['id']
      account.save
    end

    redirect_to "/"
  end

  def destroy
  	customer_key = current_user.account.customer_key
    customer = Stripe::Customer.retrieve(customer_key)
    customer.subscriptions.each {|a| a.delete}

    render :nothing => true
  end

  def update
    plan_name = params['plan']
    @account = Account.find_by_user_id(current_user.id)

    if @account && @account.customer_key
      customer = Stripe::Customer.retrieve(@account.customer_key)
      sub = customer.subscriptions
      
      if sub.data.empty?
        sub = customer.subscriptions.create(:plan => plan_name)
        render :json => {:msg => "Signed up for #{plan_name} plan."}
      else
        if sub.data.first.plan.name == "Monthly" && plan_name == "monthly"
          render :json => {:msg => "Already signed up for this plan."}, status: :not_found
        elsif sub.data.first.plan.name == "Yearly" && plan_name == "yearly"
          render :json => {:msg => "Already signed up for this plan."}, status: :not_found
        elsif sub.data.first.plan.name == "Monthly" && plan_name == "yearly"
          sub.data.first.delete
          sub = customer.subscriptions.create(:plan => plan_name)
          render :json => {:msg => "Switched to yearly plan."}, status: 200
        elsif sub.data.first.plan.name == "Yearly" && plan_name == "monthly"
          render :json => {:msg => "Already subscribed to yearly plan, please change at the end of yearly subscription."}, status: :not_found
        end
      end
    else
      render :json => {:msg => "Must add credit card before choosing plan."}, status: :not_found
    end
  end
end

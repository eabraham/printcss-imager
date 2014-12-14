require 'pry'
class AccountController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token

  def index
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

    flash[:notice] = "Card Added."
    redirect_to "/"
    #render :nothing => true
    #render :json => {msg:"Card Added"}
  end

  def destroy
  	customer_key = current_user.account.customer_key
    customer = Stripe::Customer.retrieve(customer_key)
    customer.subscriptions.each {|a| a.delete}
  end
end

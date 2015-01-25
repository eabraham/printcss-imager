class Api::V1::AcknowledgementsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    token, host = params[:token], request.host

    user = User.find_by(client_token:token, host:host)
    if user
      Acknowledgement.create(ip_address:host,user:user)
      render nothing:true, status:200
    else
      render :json=>{"error"=>"Missing client token, contact support@printcssimager.com for assistance."}, status:401
    end
  end
end

class InstructionController < ApplicationController
  def index
  	if current_user && current_user.client_token
  	  @client_token = current_user.client_token
  	else
  	  @client_token = "123456789"
  	end

  end
end

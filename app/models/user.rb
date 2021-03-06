class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :acknowledgement
  has_one :account

  before_create :generate_client_token
  
  private
  def generate_client_token
    self.client_token = SecureRandom.hex
  end
end

# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :registerable, :timeoutable,
         :rememberable, :validatable, :trackable, :two_factor_authenticatable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email, on: :create, message: 'não pode fica em branco'
  validates_uniqueness_of :email, on: :create, message: 'deve ser unico'

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
   end
   
   def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
   end
   
   def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
   end
   
   private
   
    def generate_token
     SecureRandom.hex(10)
    end
end

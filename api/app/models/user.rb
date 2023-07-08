# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :two_factor_authenticatable
  devise :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email, on: :create, message: 'não pode fica em branco'
  validates_uniqueness_of :email, on: :create, message: 'deve ser unico'
end

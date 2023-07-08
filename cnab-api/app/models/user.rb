# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email, on: :create, message: 'não pode fica em branco'
  validates_uniqueness_of :email, on: :create, message: 'deve ser unico'

  has_one :cnab
end

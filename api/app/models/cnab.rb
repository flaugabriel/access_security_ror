# frozen_string_literal: true

class Cnab < ApplicationRecord
  belongs_to :deal
  belongs_to :user
  belongs_to :store

  validates_presence_of :type_cnabs, on: :create, message: 'deve ser preenchido'
  validates_presence_of :date_occurrence, on: :create, message: 'deve ser preenchido'
  validates_presence_of :value, on: :create, message: 'deve ser preenchido'
  validates_presence_of :card, on: :create, message: 'deve ser preenchido'
  validates_presence_of :hours, on: :create, message: 'deve ser preenchido'
end

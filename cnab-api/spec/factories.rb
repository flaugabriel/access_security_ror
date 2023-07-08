# frozen_string_literal: true

FactoryBot.define do
  factory :cnab do
    date_occurrence { DateTime.now }
    value { Faker::Commerce.price }
    card { '4587' }
    hours { '172712' }
    deal { FactoryBot.create(:deal) }
    user { FactoryBot.create(:user) }
    store { FactoryBot.create(:store) }
    type_cnabs { 1 }
  end

  factory :store do
    store_owner { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number.to_s }
    store_name { Faker::Company.name }
    balance_total { Faker::Commerce.price.to_d }
  end

  factory :deal do
    type_transaction { rand(1...9) }
    description do
      [
        'Débito',
        'Boleto',
        'Financiamento',
        'Crédito',
        'Recebimento Empréstimo',
        'Vendas',
        'Recebimento TED',
        'Recebimento DOC',
        'Aluguel'
      ][rand(0...9)]
    end
    nature { %w[Entrada Saída][rand(0...2)] }
    signal { ['+', '-'][rand(0...2)] }
  end

  factory :user do
    email { Faker::Omniauth.google[:info][:email] }
    password { '12345678' }
  end
end

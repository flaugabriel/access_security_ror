# frozen_string_literal: true

Dir[Rails.root.join('lib/cnab/**/*.rb')].each { |file| require file }

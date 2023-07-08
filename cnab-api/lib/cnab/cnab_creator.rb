# frozen_string_literal: true

class CnabCreator
  def self.create_cnab(type_cnabs, date_occurrence, new_total, card, hours, deal, store_id, user_id)
    Cnab.new(
      type_cnabs:,
      date_occurrence:,
      value: new_total,
      card:,
      hours:,
      deal_id: deal,
      store_id:,
      user_id:
    )
  end
end

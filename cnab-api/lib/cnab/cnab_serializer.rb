# frozen_string_literal: true

class CnabSerializer
  def self.serialize_cnab(line)
    documents = [
      {
        type_cnabs: { start: 1, end: 1, size: 1 },
        date_occurrence: { start: 2, end: 9, size: 8 },
        value: { start: 10, end: 19, size: 10 },
        cpf: { start: 20, end: 30, size: 11 },
        card: { start: 31, end: 42, size: 12 },
        hours: { start: 43, end: 48, size: 6 },
        store_owner: { start: 49, end: 62, size: 14 },
        store_name: { start: 63, end: 81, size: 19 }
      }
    ]

    documents.first.each do |key, value|
      size_validate = line[value[:start] - 1...value[:end]]

      if size_validate.length == value[:size]
        documents.first[key] = size_validate.strip
      else
        documents.first.delete(key)
      end
    end

    documents.first
  end
end

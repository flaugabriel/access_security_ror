# frozen_string_literal: true

class BuildCnab
  def self.import(params, user_id)
    process = FileHandler.open_spreadsheet(params[:file])

    return handle_file_error(process) unless process[:file_status]

    process_spreadsheet(process[:path], user_id)
  end

  def self.handle_file_error(process)
    { message: process[:message], status: process[:file_status] }
  end

  def self.process_spreadsheet(path, user_id)
    response = { message: '', status: false }

    File.open(path) do |file|
      file.each_line do |line|
        next if line == "\n"

        object_hash = CnabSerializer.serialize_cnab(line)
        deal = DealFinder.find_by_type_transaction(object_hash[:type_cnabs].to_i)
        store = StoreFinder.find_by_cpf(object_hash[:cpf])
        new_total = object_hash[:value].to_f / 100

        if deal
          if store
            StoreUpdater.update_store(store, object_hash[:store_owner], object_hash[:store_name], deal.signal,
                                      new_total)
          else
            store = StoreCreator.create_store(object_hash[:cpf], object_hash[:store_owner], object_hash[:store_name],
                                              new_total)
          end

          object_cnab = CnabCreator.create_cnab(object_hash[:type_cnabs].to_i, object_hash[:date_occurrence],
                                                new_total, object_hash[:card].to_i, object_hash[:hours], deal.id, store.id, user_id)

          if object_cnab.save
            response[:message] = 'CNAB importada com sucesso!'
            response[:status] = true
          else
            response[:message] = 'Documento com linhas inválidas!'
          end
        else
          response[:message] = 'Atenção popule sua base de transações'
        end
      end
    end
    response
  end
end

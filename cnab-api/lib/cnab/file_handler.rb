# frozen_string_literal: true

class FileHandler
  def self.open_spreadsheet(cnab_params)
    process = { path: '', message: '', file_status: false }

    if cnab_params && cnab_params != ''
      case File.extname(cnab_params.original_filename)
      when '.txt'
        process[:path] = cnab_params.path
        process[:file_status] = true
      else
        process[:message] = "Arquivo desconhecido: #{cnab_params.original_filename}"
      end
    else
      process[:message] = 'Nenhum arquivo carregado!'
    end

    process[:file_status] = false if process[:message].present?
    process
  end
end

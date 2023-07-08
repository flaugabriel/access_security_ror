# frozen_string_literal: true

module Api
  module V1
    class CnabsController < ApiController
      def index
        cnabs = Cnab.includes(:deal, :user, :store).where(user_id: current_user.id).uniq(&:store_id)

        return json_error_response('Não foi encontrado CNABs', :not_found) unless cnabs.present?

        render json: cnabs, each_serializer: Api::V1::CnabSerializer, status: :ok
      end

      def import
        cnab = BuildCnab.import(cnab_params, current_user.id)
        if cnab[:status]
          render json: cnab, each_serializer: Api::V1::CnabSerializer, status: :ok
        else
          render json: { message: cnab[:message] }, status: :unprocessable_entity
        end
      end

      def delete_all
        cnabs = Cnab.joins(:store).where(user_id: current_user.id)
        total_cnabs = cnabs.length
        cnabs.each do |cnab|
          cnab.store.update(balance_total: 0.0)
        end
        cnabs.delete_all

        render json: { message: "Removido com sucesso! #{total_cnabs} registros" }, status: :ok
      end

      private

      def cnab_params
        params.permit(:file)
      end
    end
  end
end

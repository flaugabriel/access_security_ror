# frozen_string_literal: true

module Api
  module V1
    class MyaccountController < ApiController
      before_action :set_params, only: :update

      def profile
        render json: { data: current_user }, status: :ok
      end

      def update
        if current_user.update(set_params)
          UserMailer.update_password(current_user).deliver_now
          render json: { message: 'Perfil atualizado.' }, status: :ok
        else
          render json: { error: current_user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def forgot_password
        
      end

      private

      def set_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end

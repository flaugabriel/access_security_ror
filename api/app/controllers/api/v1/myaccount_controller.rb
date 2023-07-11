# frozen_string_literal: true

module Api
  module V1
    class MyaccountController < ApiController
      before_action :set_params, only: :update

      def profile
        render json: { data: current_user, mfa_status: current_user.otp_module_enabled? }, status: :ok
      end

      def update
        if current_user.update(set_params)
          UserMailer.update_password(current_user).deliver_now
          render json: { message: 'Senha atualizado, realize o login novamente!' }, status: :ok
        else
          render json: { error: current_user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      def open_qrcode_mfa
        qrcode = RQRCode::QRCode.new(@resource.provisioning_uri, size: 10, level: :h)
        png = qrcode.as_png(
          bit_depth: 1,
          border_modules: 4,
          color_mode: ChunkyPNG::COLOR_GRAYSCALE,
          color: "black",
          file: nil,
          fill: "white",
          module_px_size: 6,
          resize_exactly_to: false,
          resize_gte_to: false,
          size: 120
        )
        ActiveStorage::Current.host = request.base_url
        temp_blob = ActiveStorage::Blob.create_and_upload!(
          io: StringIO.new(png.to_s),
          filename: 'temp.png',
          content_type: 'image/png'
        )
        
        if temp_blob.present? 
          render json: { qrcode: temp_blob.url }, status: :ok
        else
          render json: { qrcode: 'Erro ao processar o QRCODE' }, status: :ok
        end
      end

      private

      def set_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end

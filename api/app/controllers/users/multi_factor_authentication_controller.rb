class Users::MultiFactorAuthenticationController < ApplicationController
  before_action :authenticate_api_user!
  before_action :set_user

  def verify_enable
    if current_user == @user && current_user.authenticate_otp(params[:otp_code_token], drift: 60)
      current_user.otp_module_enabled!
      render json: { messager: 'MFA ativado!' }, status: :ok
    else
      render json: { messager: 'Token invalido!' }, status: :unprocessable_entity
    end
  end

  def verify_disabled
      current_user.otp_module_disabled!
      render json: { messager: 'MFA Desativado' }, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

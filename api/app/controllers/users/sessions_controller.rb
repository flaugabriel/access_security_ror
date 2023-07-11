class Users::SessionsController < ApplicationController
  before_action :authenticate_api_user!
  
  def create
    if current_user && current_user.otp_module_disabled?
      render json: { messager: 'Bem vindo!'} , status: :ok
    elsif current_user && current_user.otp_module_enabled?
      if params[:otp_code_token].size > 0
        if current_user.authenticate_otp(params[:otp_code_token], drift: 60)
          render json: { messager: 'Bem vindo!'}, status: :ok
        else
          destroy_api_user_session_path current_user
          render json: { messager: 'Suas credenciais são invalidas.'}, status: '505'
        end
      else
        destroy_api_user_session_path current_user
        render json: { messager: 'Sua conta precisa fornecer um token valido.'}, status: '404'
      end
    end
  end
end
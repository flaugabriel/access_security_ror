# frozen_string_literal: true

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def login(current_user)
    post '/api/auth/sign_in', params: { email: current_user.email, password: current_user.password }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
  end
end

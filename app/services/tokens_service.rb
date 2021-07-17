# логика работы с JWT токенами
module TokensService
  # хэш секретов
  SECRET = { :access_token => Rails.configuration.jwt_access_secret, :refresh_token => Rails.configuration.jwt_refresh_secret }.freeze
  # генерируем новую пару токенов, после авторизации
  def TokensService.generate_tokens(payload)
    exp = 144.hours.from_now.to_i
    exp_payload = { data: payload, exp: exp }
    result = {}
    result[:refresh] = JWT.encode exp_payload, SECRET[:refresh_token]
    exp_payload[:exp] = 1.hours.from_now.to_i
    result[:access] = JWT.encode exp_payload, SECRET[:access_token]
    return result
  end

  # обновляем или сохраняем refresh_token в базе
  def TokensService.save_token(user_id, refresh_token)
    @token = Token.find_by(user_id: user_id)
    if @token
      @token.refresh_token = refresh_token
      return @token.save!
    end
    @token = Token.create!({ user_id: user_id, refresh_token: refresh_token })
  end
  # удаляем токен обновлений из базы
  def TokensService.remove_token(refresh_token)
    @token = Token.destroy_by(refresh_token: refresh_token)
  end

  # валидируем токен
  # type - тип токена: :access_token или :refresh_token
  def TokensService.validate_token(token, secret)
    JWT.decode token, secret
  rescue JWT::RequiredDependencyError
    puts "JWT.RequiredDependencyError"
    false
  rescue JWT::VerificationError
    puts "JWT.VerificationError"
    false
  rescue JWT::ExpiredSignature
    puts "JWT.ExpiredSignature"
    false
  rescue JWT::IncorrectAlgorithm
    puts "JWT.IncorrectAlgorithm"
    false
  end
end

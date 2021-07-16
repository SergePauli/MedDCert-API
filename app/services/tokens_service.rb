# логика работы с JWT токенами
module TokensService
  # генерируем новую пару токенов, после авторизации
  def TokensService.generate_tokens(payload)
    result = {}
    payload[:exp] = 144.hours.from_now.to_i
    result[:refresh] = JWT.encode(payload, Rails.configuration.jwt_refresh_secret)
    payload[:exp] = 1.hours.from_now.to_i
    result[:access] = JWT.encode(payload, Rails.configuration.jwt_access_secret)
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
end

class JsonWebToken
  REFRESH_SECRET = Rails.application.secrets.secret_key_base.freeze
  ACCESS_SECRET = REFRESH_SECRET.reverse.freeze
  class << self
    # генерируем оба токена сразу
    def generate_tokens(payload)
      exp = 144.hours.from_now.to_i
      exp_payload = { data: payload, exp: exp }
      result = {}
      result[:refresh] = JWT.encode exp_payload, REFRESH_SECRET
      exp_payload[:exp] = 1.hours.from_now.to_i
      result[:access] = JWT.encode exp_payload, ACCESS_SECRET
      result
    end

    # валидируем токен
    # secret - в зависимости от токена: REFRESH_SECRET или ACCESS_SECRET
    def validate_token(token, secret)
      body = JWT.decode(token, secret)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    # удаляем токен обновлений из базы
    def remove_token(refresh_token)
      @token = Token.destroy_by(refresh_token: refresh_token)
    end

    # обновляем или сохраняем refresh_token в базе
    def save_token(user_id, refresh_token)
      @token = Token.find_by(user_id: user_id)
      if @token
        @token.refresh_token = refresh_token
        return @token.save!
      end
      @token = Token.create!({ user_id: user_id, refresh_token: refresh_token })
    end
  end
end

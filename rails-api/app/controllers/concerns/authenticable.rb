module Authenticable
    private 

    def authenticable_with_token
        @token ||= request.headers['Authorization']
        unless valid_token?
            render json: {
                errors: 'Você não possui autorização',
                status: :unauthorized
            }
        end
    end

    def valid_token?
        @token.present?
    end
end
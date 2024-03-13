class AuthService
    SECRET_KEY = "test123"
    ALGORITHM = 'HS256'

    def self.handle_login(params)
        result = User.find_by!(email:params[:email])&.authenticate(params[:password])
        if !result
            return{
                status:false
            }
        else
            payload = {
                id:result.id,
                email:result.email,
                exp: 30.minutes.from_now.to_i
            }
            token = JWT.encode payload, SECRET_KEY, ALGORITHM
            return {
                status:true,
                token:token
            }
        end
    end

    def self.get_current_user(token)
        decoded = JWT.decode token, SECRET_KEY, true, {algorithm: ALGORITHM}
        decoded[0]["id"]
    end
end
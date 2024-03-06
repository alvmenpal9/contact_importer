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
                exp: 1.minute.from_now.to_i
            }
            token = JWT.encode payload, SECRET_KEY, ALGORITHM
            return {
                status:true,
                token:token
            }
        end
    end
end
module Api
    module V1
        class AuthController < ApplicationController
            def login
                auth = AuthService.handle_login(params)
                if !auth[:status]
                    render json: {message:'invalid email or password'}, status: :unprocessable_entity
                else
                    session[:current_user] = auth[:token]
                    render json: {token:auth[:token]}, status: 200
                end
            end
        end
    end
end
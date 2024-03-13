module Api
    module V1
        class UsersController < ApplicationController
            def create
                user = User.create!(email: params[:email], password: params[:password])
                render json: {message:"user created"}, status: :created
            rescue ActiveRecord::RecordInvalid => e
                render json: {errors:e.record.errors.full_messages}, status: :unprocessable_entity
            end
        end
    end
end
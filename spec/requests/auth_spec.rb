require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "POST /login" do
    context "when it sends valid fields" do
      it "sends status 200, and a token" do
        user = User.create!(email:"john@doe.com", password:"pass123")
        post "/api/v1/login", params: {email:"#{user.email}", password:"#{user.password}"}
        expect(response).to have_http_status(200)
        expect(response.body).to include("token")
      end
    end

    context "when fields are incorrect" do
      it "sends an HTTP 404 response if user does not exist" do
        post "/api/v1/login", params: {email:"john@doe.com", password: "pass123"}
        expect(response).to have_http_status(404) 
      end

      it "sends an HTTP 422 response if credentials are invalid" do
        user = User.create!(email:"john@doe.com", password:"pass123")
        post "/api/v1/login", params: {email:"#{user.email}", password: "pass1234"}
        expect(response).to have_http_status(422)
         expect(response.body).to include("invalid email or password")
      end
    end
    
  end
end

require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    context "when fields are valid" do
      it "creates the user" do
        expect{
          post "/api/v1/users", params: {email:"john@doe.com", password:"pass123"}
      }.to change(User, :count).from(0).to(1)
      expect(response).to have_http_status(:created)
      expect(response.body).to include("user created")
      end
    end

    context "when user already exists" do
      it "sends an HTTP 422 response" do
        user = User.create(email:"john@doe.com", password:"pass123")
        post "/api/v1/users", params: {email:"#{user.email}"}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when fields are invalid" do
      it "sends an HTTP 422 response" do
        post "/api/v1/users", params: {email: "", password: "pass123"}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Email can't be blank")
      end

      it "sends an HTTP 422 response" do
        post "/api/v1/users", params: {email: "john@doe.com", password: ""}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Password can't be blank")
      end
    end
  end
end

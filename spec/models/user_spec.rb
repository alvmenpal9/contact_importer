require 'rails_helper'

RSpec.describe User, type: :model do

  it "sends correct fields" do
    user = User.create(email:"john@doe.com", password: "pass123")
    expect {user.save!}.not_to raise_error
    expect(User.last).to eq(user)
  end

  it "sends blank fields" do
    user = User.create(email:"", password: "")
    expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank, Email is invalid, Password can't be blank")
  end

  it "sends blank email" do
    user = User.create(email:"", password: "pass123")
    expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email can't be blank, Email is invalid")
  end

  it "sends invalid email" do
    user = User.create(email:"johndoe.com", password: "pass123")
    expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email is invalid")
  end

  it "sends blank password" do
    user = User.create(email:"john@doe.com", password: "")
    expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
  end

  it "sends an existing email" do
    user_1 = User.create(email:"john@doe.com", password:"pass123")
    user_2 = User.create(email:"john@doe.com", password:"pass123")
    expect {user_2.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")  
  end
end

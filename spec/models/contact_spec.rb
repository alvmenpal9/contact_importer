require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "sends valid fields" do
    contact = Contact.new(name:"John Doe", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact.save!}.not_to raise_error
    expect(Contact.last).to eq(contact)
  end

  it "tries to save an existing contact" do
    contact_1 = Contact.create!(name:"John Doe", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    contact_2 = Contact.new(name:"John Doe", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact_2.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Email has already been taken")
  end

  it "sends blank name" do 
    contact = Contact.new(name:"", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe1.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank, Name is invalid")
  end

  it "sends an invalid name" do 
    contact = Contact.new(name:"John!Doe", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe1.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name is invalid")
  end

  it "sends an invalid phone number" do
    contact = Contact.new(name:"John Doe", phone_number: "5730000011225456", date_of_birth: "1980-12-15", email: "john@doe1.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Phone number is invalid")
  end

  it "sends an invalid date of birth" do
    contact = Contact.new(name:"John Doe", phone_number: "573000001122", date_of_birth: "1980/12/15", email: "john@doe1.com", credit_card: "4506112211221122", address:"Calle 60 # 11 11")
    expect {contact.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Date of birth is invalid")
  end

  it "address is not present" do
    contact = Contact.new(name:"John Doe", phone_number: "573000001122", date_of_birth: "1980-12-15", email: "john@doe1.com", credit_card: "4506112211221122", address:"")
    expect {contact.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Address can't be blank")
  end
end

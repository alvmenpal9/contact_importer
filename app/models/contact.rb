require 'bcrypt'
class Contact < ApplicationRecord
    include BCrypt
    VALID_NAME = /\A[a-zA-Z\- ]+\z/
    VALID_PHONE_NUMBER = /\A\d{1,14}\z/
    VALID_DATE_OF_BIRTH = /\A[0-9][0-9][0-9][0-9]-?[0-1][0-9]-?[0-3][0-9]\z/
    VALID_EMAIL = /\A([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\z/

    before_save :set_franchise
    before_save :hash_credit_card_number
    validates :name, presence: true, format: { with: VALID_NAME }
    validates :phone_number, presence: true, format: {with: VALID_PHONE_NUMBER}
    validates :date_of_birth, presence: true, format: {with: VALID_DATE_OF_BIRTH}
    validates :email, presence: true, format: { with: VALID_EMAIL }, uniqueness: true
    validates :address, presence: true

    private
    def hash_credit_card_number
        last_digits = credit_card.to_s.last(4)
        digits = credit_card.to_s[0, credit_card.to_s.length - 4]
        hashed_digits = BCrypt::Password.create(digits)
        self.credit_card = "#{hashed_digits}#{last_digits}"
    end

    def set_franchise
        if self.credit_card.first(2) == '37' && self.credit_card.length == 15
            self.franchise = "american express"
        elsif self.credit_card.first(2) == '30' && self.credit_card.length == 14
            self.franchise = "diners club"
        elsif self.credit_card.first(4) == '6011' && (self.credit_card.length >= 16 && self.credit_card.length <= 19)
            self.franchise = "discover"
        elsif self.credit_card.first(4).to_i >= 3528 && self.credit_card.first(4).to_i <= 3589 && (self.credit_card.length >= 16 && self.credit_card.length <= 19)
            self.franchise = "jcb"
        elsif self.credit_card.first(2).to_i >= 51 && self.credit_card.first(2).to_i <= 55 && self.credit_card.length >= 16
            self.franchise = "mastercard"
        elsif self.credit_card.first(1) && (self.credit_card.length == 13 || self.credit_card.length == 16 || self.credit_card.length == 19)
            self.franchise = "visa"
        end
    end
end
class Contact < ApplicationRecord
    VALID_NAME = /\A[a-zA-Z\- ]+\z/
    VALID_PHONE_NUMBER = /\A\+[0-9]\d{1,14}\z/
    VALID_DATE_OF_BIRTH = /\A[0-9][0-9][0-9][0-9]-?[0-1][0-9]-?[0-3][0-9]\z/
    VALID_EMAIL = /\A([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\z/

    before_save :test_method
    validates :name, presence: true, format: { with: VALID_NAME }
    validates :phone_number, presence: true, format: {with: VALID_PHONE_NUMBER}
    validates :date_of_birth, presence: true, format: {with: VALID_DATE_OF_BIRTH}
    validates :email, presence: true, format: { with: VALID_EMAIL }
    validates :address, presence: true

    private
    def test_method
        self.franchise = "test"
    end
end
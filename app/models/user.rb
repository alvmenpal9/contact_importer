class User < ApplicationRecord
    before_save {self.email = email.downcase}
    VALID_REGEX_EMAIL = /\A([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\z/

    validates :email, presence: true, uniqueness: true, format: { with: VALID_REGEX_EMAIL }

    has_secure_password
end
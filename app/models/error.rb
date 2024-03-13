class Error < ApplicationRecord
    validates :contact_name, presence: true
    validates :error, presence: true
end
module Api
    module V1
        class ContactsController < ApplicationController
            require 'smarter_csv'

            KEYWORDS = {
                /nombre/i => :name,
                /fecha.*nac/i => :date_of_birth,
                /email|correo/i => :email,
                /tel|telefono/i => :phone_number,
                /tc|tarjeta.*cred/i => :credit_card,
                /dir|direccion/i => :address
            }

            def create
                csv_file = params[:file]
                
                if csv_file.present? && csv_file.content_type == 'text/csv'
                    data = SmarterCSV.process(csv_file)
                    
                    data.each do |row|
                        Contact.create!(map_fields(row))
                    end
                end
            end

            private
            def map_fields(row)
                mapped_fields = {}
                KEYWORDS.each do |keyword, attribute_value|
                    matched_column = row.keys.find {|column| column =~ keyword}
                    mapped_fields[attribute_value] = row[matched_column] if matched_column
                end

                mapped_fields
            end
        end
    end
end
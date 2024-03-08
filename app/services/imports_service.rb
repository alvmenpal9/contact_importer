require 'smarter_csv'
class ImportsService
    KEYWORDS = {
        /nombre/i => :name,
        /fecha.*nac/i => :date_of_birth,
        /email|correo/i => :email,
        /tel|telefono/i => :phone_number,
        /tc|tarjeta.*cred/i => :credit_card,
        /dir|direccion/i => :address
    }

    def self.process_file(file, import_record, user_id)
        csv_file = file  
        errors = []
        if csv_file.present? && csv_file.content_type == 'text/csv'
            data = SmarterCSV.process(csv_file)
                    
            data.each do |row|
                begin
                    record = Contact.create!(map_fields(row))
                    record.imported_by = user_id
                    record.save!
                rescue ActiveRecord::RecordInvalid => e
                    puts e.record.name
                    puts e.record.errors.full_messages
                end
            end
        end
        import_record.status = "finished"
        import_record.save!
    end

    def self.get_user_imports(user_id)
        
    end

    private
    def self.map_fields(row)
        mapped_fields = {}
        KEYWORDS.each do |keyword, attribute_value|
            matched_column = row.keys.find {|column| column =~ keyword}
            mapped_fields[attribute_value] = row[matched_column] if matched_column
        end
        mapped_fields
    end
end
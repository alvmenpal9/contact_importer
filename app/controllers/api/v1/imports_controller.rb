module Api
    module V1
        class ImportsController < ApplicationController
            before_action :current_user

            def create
                import_record = Import.new(user_id:@current_user, status: 'on hold')
                import_record.file_name.attach(params[:file])
                if import_record.save!
                    render json:{message:'processing your file'}, status: 200
                    ProcessImportJob.perform_now(params[:file], import_record, @current_user)
                end
            end

            def index
                imports = Import.where(user_id:@current_user.to_i).map do |import|
                    {
                        id: import.id,
                        status: import.status,
                        file_name: import.file_name.filename.to_s,
                        created_at: import.created_at
                    }
                end
                render json:{imports: imports}, status: 200
            end

            def show
                import = ImportsService.send_import(params[:id])
                render json: {import:import}, status: 200
            end
        end
    end
end
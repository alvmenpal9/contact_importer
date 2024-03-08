module Api
    module V1
        class ImportsController < ApplicationController
            before_action :current_user

            def create
                import_record = Import.create!(user_id:@current_user, file_name:params[:file].original_filename, status: 'on hold')
                render json:{message:'processing your file'}, status: 200
                ProcessImportJob.perform_now(params[:file], import_record, @current_user)
            end

            def index
                imports = Import.all().where(user_id:@current_user.to_i)
                render json:{imports: imports}, status: 200
            end
        end
    end
end
module Api
    module V1
        class ContactsController < ApplicationController
            before_action :current_user
            def index
                contacts = Contact.where(imported_by:@current_user).page(params[:page])
                total_contacts = Contact.count
                render json:{
                    contacts: contacts,
                    total: total_contacts,
                    total_pages: contacts.total_pages,
                    current_page: contacts.current_page,
                    next_page: contacts.next_page,
                    prev_page: contacts.prev_page,
                }, status: 200
            end
        end
    end
end
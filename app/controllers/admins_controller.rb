class AdminsController < ApplicationController
    
    before_action :require_login
    before_action :check_admin_rights
    
    def index
        @clients = Client.all
    end
end

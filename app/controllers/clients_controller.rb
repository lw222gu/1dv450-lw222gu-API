class ClientsController < ApplicationController
    
    before_action :require_login
    before_action :fetch_client, only: [:destroy, :revoke, :reactivate]
    
    def index
        @user = User.find(session[:userid])
    end
    
    def new
        @client = Client.new
    end
    
    def create
        @client = Client.new(client_params)
        @client.key = DateTime.now.strftime('%s') + SecureRandom.hex(20)
        @client.user_id = session[:userid]
        
        if @client.save
           flash[:success] = 'Applikationen sparades.'
           redirect_to clients_path
        else
            flash[:danger] = 'Applikationen kunde inte sparas.'
            render :action => 'new'
        end
    end
    
    def destroy
        @client.destroy
        flash[:success] = 'Applikationen raderades.'
        if current_user.admin?
            redirect_to admins_path
        else
            redirect_to clients_path
        end
    end
    
    def revoke
        @client.active = false
        @client.save
        flash[:success] = 'Applikationen har inaktiverats.'
        redirect_to admins_path
    end
    
    def reactivate
        @client.active = true
        @client.save
        flash[:success] = 'Applikationen har återaktiverats.'
        redirect_to admins_path
    end
    
    private
    
    def client_params
        params.require(:client).permit(:name, :description, :url)
    end
    
    private
    
    def fetch_client
      @client = Client.find(params[:id])
    end
end

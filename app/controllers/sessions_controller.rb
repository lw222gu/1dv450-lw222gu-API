class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        u = User.find_by_username(params[:username])
        if u && u.authenticate(params[:password])
            session[:userid] = u.id
            if u.admin
                redirect_to admins_path
            else
                redirect_to clients_path
            end
        else
            flash[:danger] = 'Fel vid inloggning.'
            redirect_to root_path
        end
    end
    
    def destroy
        session[:userid] = nil
        flash[:success] = 'Du har loggat ut.'
        redirect_to root_path
    end
end

class UsersController < ApplicationController
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
           session[:userid] = @user.id 
           flash[:success] = 'Du är nu en registrerad användare.'
           redirect_to clients_path
        else
            if User.find_by username: @user.username
                flash[:danger] = 'Användarnamnet är upptaget. Prova med något annat.'
                render :action => 'new' and return
            end
            flash[:danger] = 'Något gick fel vid registreringen.'
            render 'new'
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

end

class EventsController < ApplicationController
  before_action :require_login

  def index
    @user = User.find(session[:userid])
  end

  def create
  end

  def new
  end

  def destroy
  end
end

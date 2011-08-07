class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    if user_signed_in?
      redirect_to :dashboard
    end
  end
  
  def dashboard
    @apps = current_user.apps
    
    # if apps.count == 0 we prepare an app to be created during the tutorial
    if @apps.count == 0
      @app = App.new
      @app.url = 'http'
    else
      @load_app_id = params[:app] == nil ? @apps.first.id : params[:app]
    end
    
  end
end

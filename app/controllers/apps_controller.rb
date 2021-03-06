class AppsController < ApplicationController
  before_filter :authenticate_user!, :except => [:code]
  # GET /apps
  # GET /apps.xml
  def index
    @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.xml
  def show
    @app = App.find(params[:id])
    @tab = params[:tab] == nil ? 'pages' : params[:tab]
    if (request.xhr?)
      render :partial => 'show_ajax'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @page }
      end
    end
  end

  #display the javascript
  def code
    require 'uri'
    
    @app = App.find(params[:id])

    origin = request.headers['HTTP_REFERER']
    display_code = origin.include? @app.url
    
    if !display_code
      render :template => 'apps/no_code.js.erb'
      return
    end
    if params[:url]
      page_url = URI.unescape(params[:url])
      @page = Page.find_by_url(page_url)

      if @page
        @panel = @page.panel || nil
        @boxes = @page.boxes || nil
      end
      
    end
    
  end


  def settings
    @app = App.find(params[:id])
    render :partial => 'settings'
  end
  
  # GET /apps/new
  # GET /apps/new.xml
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # POST /apps
  # POST /apps.xml
  def create
    @app = App.new(params[:app])
    @app.user = current_user
    respond_to do |format|
      if @app.save
        format.html { redirect_to(dashboard_path, :notice => 'App was successfully created.') }
        format.xml  { render :xml => @app, :status => :created, :location => @app }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.xml
  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to(dashboard_path, :notice => 'App was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.xml
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    if request.xhr?
      render :header => 200
    else

      respond_to do |format|
        format.html { redirect_to(apps_url) }
        format.xml  { head :ok }
      end

    end
  end
end

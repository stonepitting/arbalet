class PanelsController < ApplicationController
  # GET /panels
  # GET /panels.xml
  def index

    cond = {}
    
    if params[:app_id]
      @app = App.find(params[:app_id])
      cond = {:app_id => @app.id}
    end
    
    @panels = Panel.all(:conditions => cond)

    #New page to be saved
    @panel = Panel.new
    @panel.app_id = @app.id
    
    if (request.xhr?)
      if @panels.count == 0
        render :partial => 'no_panels'
      else
        render :partial => 'index_ajax'
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @panels }
      end
    end

  end

  # GET /panels/1
  # GET /panels/1.xml
  def show
    @panel = Panel.find(params[:id])

    if (request.xhr?)
      render :partial => 'show_ajax'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @panel }
      end
    end
  end

  def display
    @panel = Panel.find(params[:id])
    render :layout => false
  end

  # GET /panels/new
  # GET /panels/new.xml
  def new
    @panel = Panel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel }
    end
  end

  # GET /panels/1/edit
  def edit
    @panel = Panel.find(params[:id])
    @app = @panel.app

    if request.xhr?
      render :layout => false
    end
  end

  # POST /panels
  # POST /panels.xml
  def create
    @panel = Panel.new(params[:panel])

    respond_to do |format|
      if @panel.save
        format.html { redirect_to(app_panels_path(@panel.app_id), :notice => 'Panel was successfully created.') }
        format.xml  { render :xml => @panel, :status => :created, :location => @panel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panels/1
  # PUT /panels/1.xml
  def update
    @panel = Panel.find(params[:id])

    respond_to do |format|
      if @panel.update_attributes(params[:panel])
        format.html { redirect_to(app_panels_path(@panel.app_id), :notice => 'Panel was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panels/1
  # DELETE /panels/1.xml
  def destroy
    @panel = Panel.find(params[:id])
    @panel.destroy

    if request.xhr?
      head :ok
    else
      respond_to do |format|
        format.html { redirect_to(panels_url) }
        format.xml  { head :ok }
      end
    end
  end
end

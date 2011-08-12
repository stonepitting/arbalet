class BoxesController < ApplicationController
  before_filter :authenticate_user!, :except => [:display]
  # GET /boxes
  # GET /boxes.xml
  def index
    cond = {}
    
    if params[:app_id]
      @app = App.find(params[:app_id])
      cond = {:app_id => @app.id}
    end
    
    @boxes = Box.all(:conditions => cond)

    #New box to be saved
    @box = Box.new
    @box.app_id = @app.id
  
    
    if (request.xhr?)
      if @boxes.count == 0
        render :partial => 'no_boxes'
      else
        render :partial => 'index_ajax'
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @boxes }
      end
    end
  end

  def display
    @box = Box.find(params[:id])

    render :layout => false
  end

  # GET /boxes/1
  # GET /boxes/1.xml
  def show
    @box = Box.find(params[:id])
    if (request.xhr?)
      render :partial => 'show_ajax'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @box }
      end
    end
  end

  # GET /boxes/new
  # GET /boxes/new.xml
  def new
    
    @box = Box.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @box }
    end
  end

  # Miniform displayed for the toolbar.
  # Needs
  # - page => create one for the app if not existing
  # - app_id
  def miniform

    # get the necessary date
    app_id =  params[:app_id]
    page_url = params[:page_url]
    target_id = params[:target_id]

    @app = current_user.apps.find(app_id)
    puts '=================='
    puts @app.name

    if !@app
      return
    end

    @page = @app.pages.find_by_url(page_url)
    puts '====================='
    if @page == nil
      @page = Page.new()
      @page.user = current_user
      @page.app = @app
      @page.url = page_url
      @page.name = page_url
      @page.enabled = true
      @page.save
    end
    puts @page.name
    
    @box = Box.new
    @box.target_id = target_id
    @box.app_id = @app.id

    respond_to do |format|
      format.html {render :layout => 'mini'}
      format.xml  { render :xml => @box }
    end
  end

  # GET /boxes/1/edit
  def edit
    @box = Box.find(params[:id])
    @app  = @box.app

    if request.xhr?
      render :layout => false
    end
  end

  # POST /boxes
  # POST /boxes.xml
  def create
    @box = Box.new(params[:box])
    @box.user = current_user
    respond_to do |format|
      if @box.save
        if params[:page_id]
          @page = Page.find(params[:page_id])
          page_box = PageBox.new
          page_box.box = @box
          page_box.page = @page
          page_box.app_id = @page.app_id
          page_box.user = current_user
          page_box.save
        end
        
        format.html { redirect_to(app_boxes_path(@box.app_id), :notice => 'Box was successfully created.') }
        format.xml  { render :xml => @box, :status => :created, :location => @box }
        
      else
          format.html { render :action => "new" }
          format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  # PUT /boxes/1
  # PUT /boxes/1.xml
  def update
    @box = Box.find(params[:id])

    respond_to do |format|
      if @box.update_attributes(params[:box])
        format.html { redirect_to(app_boxes_path(@box.app_id), :notice => 'Box was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.xml
  def destroy
    @box = Box.find(params[:id])
    @box.destroy

    if request.xhr?
      head :ok
    else

      respond_to do |format|
        format.html { redirect_to(boxes_url) }
        format.xml  { head :ok }
      end
    end
  end
end

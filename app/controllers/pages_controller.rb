class PagesController < ApplicationController
  before_filter :authenticate_user!
  # GET /pages
  # GET /pages.xml
  def index
    cond = {}
    
    if params[:app_id]
      @app = App.find(params[:app_id])
      cond = {:app_id => @app.id}
    end
    
    @pages = Page.all(:conditions => cond)

    #New page to be saved
    @page = Page.new
    @page.app_id = @app.id
    @page.url = 'http://'
    
    @panels = Panel.all
    
    if (request.xhr?)
      if @pages.count == 0
        render :partial => 'no_pages'
      else
        render :partial => 'index_ajax'
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pages }
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])
    if (request.xhr?)
      render :partial => 'show_ajax'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @page }
      end
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    @app  = @page.app
    @panels = Panel.all
    
    @page_boxes = @page.boxes

    # p_boxes will be used for display so that we have direct access to the page_boxes row to delete
    @p_boxes = @page.page_boxes 
    all_boxes = Box.where(:app_id => @app.id)
    @available_boxes = all_boxes - @page_boxes

    if request.xhr?
      render :layout => false
    end
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
    @page.user = current_user
    respond_to do |format|
      if @page.save
          format.html { redirect_to(app_pages_path(@page.app_id), :notice => 'Page was successfully created.') }
          format.xml  { render :xml => @page, :status => :created, :location => @page }
        
      else
          format.html { render :action => "new" }
          format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to(app_pages_path(@page.app_id), :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    if request.xhr?
      head :ok
    else

      respond_to do |format|
        format.html { redirect_to(pages_url) }
        format.xml  { head :ok }
      end
    end
  end
end

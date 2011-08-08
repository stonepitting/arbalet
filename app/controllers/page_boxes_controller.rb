class PageBoxesController < ApplicationController
  # GET /page_boxes
  # GET /page_boxes.xml
  def index
    @page_boxes = PageBox.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_boxes }
    end
  end

  # GET /page_boxes/1
  # GET /page_boxes/1.xml
  def show
    @page_box = PageBox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_box }
    end
  end

  # GET /page_boxes/new
  # GET /page_boxes/new.xml
  def new
    @page_box = PageBox.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_box }
    end
  end

  # GET /page_boxes/1/edit
  def edit
    @page_box = PageBox.find(params[:id])
  end

  # POST /page_boxes
  # POST /page_boxes.xml
  def create
    @page_box = PageBox.new(params[:page_box])
    page = @page_box.page
    @page_box.user = current_user
    @page_box.app = page.app
    respond_to do |format|
      if @page_box.save
        format.html { redirect_to(@page_box, :notice => 'Page box was successfully created.') }
        format.xml  { render :xml => @page_box, :status => :created, :location => @page_box }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_boxes/1
  # PUT /page_boxes/1.xml
  def update
    @page_box = PageBox.find(params[:id])

    respond_to do |format|
      if @page_box.update_attributes(params[:page_box])
        format.html { redirect_to(@page_box, :notice => 'Page box was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_box.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_boxes/1
  # DELETE /page_boxes/1.xml
  def destroy
    @page_box = PageBox.find(params[:id])
    @page_box.destroy

    respond_to do |format|
      format.html { redirect_to(page_boxes_url) }
      format.xml  { head :ok }
    end
  end
end

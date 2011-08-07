class TipsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /tips
  # GET /tips.xml
  def index
    cond = {}
    
    if params[:app_id]
      @app = App.find(params[:app_id])
      puts @app.id
      cond = {:app_id => @app.id}
    end
    
    @tips = Tip.all(:conditions => cond)
    
    #New page to be saved
    @tip = Tip.new
    @tip.app_id = @app.id
    
    if (request.xhr?)
      if @tips.count == 0
        render :partial => 'no_tips'
      else
        render :partial => 'index_ajax'
      end
    else

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tips }
      end
    end
  end

  # GET /tips/1
  # GET /tips/1.xml
  def show
    @tip = Tip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/new
  # GET /tips/new.xml
  def new
    @tip = Tip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tip }
    end
  end

  # GET /tips/1/edit
  def edit
    @tip = Tip.find(params[:id])
    @app  = @tip.app   
    if request.xhr?
      render :layout => false
    end
  end

  # POST /tips
  # POST /tips.xml
  def create
    @tip = Tip.new(params[:tip])
    @tip.user = current_user

    respond_to do |format|
      if @tip.save
        format.html { redirect_to(app_tips_path(@tip.app_id), :notice => 'Tip was successfully created.') }
        format.xml  { render :xml => @tip, :status => :created, :location => @tip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tips/1
  # PUT /tips/1.xml
  def update
    @tip = Tip.find(params[:id])

    respond_to do |format|
      if @tip.update_attributes(params[:tip])
        format.html { redirect_to(app_tips_path(@tip.app_id), :notice => 'Tip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.xml
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    if request.xhr?
      head :ok
    else

      respond_to do |format|
        format.html { redirect_to(tips_url) }
        format.xml  { head :ok }
      end
    end
  end
end

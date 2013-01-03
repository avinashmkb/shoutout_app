class BusinessesController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
 
 
 def baseurl
 	# get hostname or ip adress 
  	ipaddress=server_ipaddress()
  	@baseurl = "http://" + ipaddress +"/dashboard"
 end 

  # GET /businesses
  # GET /businesses.json
  def index
  	if session[:user_id] == 3 # Mapping to the admin login else we deliver 404 page
		  	baseurl()
		  	session[:pagetobeloaded]= "category_edit"
		    @businesses = Business.all
		
		    respond_to do |format|
		      format.html # index.html.erb
		      format.json { render json: @businesses }
		    end
	end 	    
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
  	if session[:user_id] == 3 # Mapping to the admin login else we deliver 404 page
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @business = Business.find(params[:id])
	
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @business }
	    end
	end     
  end

  # GET /businesses/new
  # GET /businesses/new.json
  def new
    @business = Business.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business }
    end
  end

  # GET /businesses/1/edit
  def edit
  if session[:user_id] == 3 # Mapping to the admin login else we deliver 404 page	
  	baseurl()
  	session[:pagetobeloaded]= "category_edit"
    @business = Business.find(params[:id])
   end     
  end

  # POST /businesses
  # POST /businesses.json
  def create
  	baseurl()
    @business = Business.new(params[:business])

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render json: @business, status: :created, location: @business }
      else
        format.html { render action: "new" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /businesses/1
  # PUT /businesses/1.json
  def update
  	baseurl()
    @business = Business.find(params[:id])

    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
  if session[:user_id] == 3 # Mapping to the admin login else we deliver 404 page	
	  	baseurl()
	    @business = Business.find(params[:id])
	    @business.destroy
	
	    respond_to do |format|
	      format.html { redirect_to businesses_url }
	      format.json { head :no_content }
	    end
	end     
  end
end

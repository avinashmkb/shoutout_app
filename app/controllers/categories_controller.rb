class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def baseurl
 	# get hostname or ip adress 
  	ipaddress=server_ipaddress()
  	@baseurl = "http://" + ipaddress +"/dashboard"
 end 
 
  def index
  	if session[:user_id] == 3 
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @categories = Category.all
	
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @categories }
	    end
	end     
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  	if session[:user_id] == 3 
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @category = Category.find(params[:id])
	
	    respond_to do |format|
	      format.html # show.html.erb
	      format.json { render json: @category }
	    end
	end     
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
  	if session[:user_id] == 3 
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @category = Category.new(params[:category])
	
	    respond_to do |format|
	      if @category.save
	        format.html { redirect_to @category, notice: 'Category was successfully created.' }
	        format.json { render json: @category, status: :created, location: @category }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	      end
	    end
	end    
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end

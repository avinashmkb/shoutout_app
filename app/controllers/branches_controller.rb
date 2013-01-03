class BranchesController < ApplicationController
  
  def baseurl
 	# get hostname or ip adress 
  	ipaddress=server_ipaddress()
  	@baseurl = "http://" + ipaddress +"/dashboard"
 end 
  
  # GET /branches
  # GET /branches.json
  def index
  	if session[:user_id] == 3 
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @branches = Branch.all
	
	    respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @branches }
	    end
	end     
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
  	
  	if session[:user_id] == 3 
  		baseurl()
  		session[:pagetobeloaded]= "category_edit"
   	    @branch = Branch.find(params[:id])

    	respond_to do |format|
      		format.html # show.html.erb
      	format.json { render json: @branch }
	    end
    end 	    
  end

  # GET /branches/new
  # GET /branches/new.json
  def new
  	if session[:user_id] == 3 
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @branch = Branch.new
	
	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @branch }
	    end
	end    
  end

  # GET /branches/1/edit
  def edit
   if session[:user_id] == 3 	
	  	baseurl()
	  	session[:pagetobeloaded]= "category_edit"
	    @branch = Branch.find(params[:id])
	end    
  end

  # POST /branches
  # POST /branches.json
  def create
  	if session[:user_id] == 3 
		    @branch = Branch.new(params[:branch])
		
		    respond_to do |format|
		      if @branch.save
		        format.html { redirect_to @branch, notice: 'Branch was successfully created.' }
		        format.json { render json: @branch, status: :created, location: @branch }
		      else
		        format.html { render action: "new" }
		        format.json { render json: @branch.errors, status: :unprocessable_entity }
		      end
		    end
	end	    
  end

  # PUT /branches/1
  # PUT /branches/1.json
  def update
  	if session[:user_id] == 3 
		    @branch = Branch.find(params[:id])
		
		    respond_to do |format|
		      if @branch.update_attributes(params[:branch])
		        format.html { redirect_to @branch, notice: 'Branch was successfully updated.' }
		        format.json { head :no_content }
		      else
		        format.html { render action: "edit" }
		        format.json { render json: @branch.errors, status: :unprocessable_entity }
		      end
		    end
	  end 	    
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
	  if session[:user_id] == 3 
	    @branch = Branch.find(params[:id])
	    @branch.destroy
	
	    respond_to do |format|
	      format.html { redirect_to branches_url }
	      format.json { head :no_content }
	    end
	end     
  end
end

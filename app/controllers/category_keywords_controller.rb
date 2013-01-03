class CategoryKeywordsController < ApplicationController
  # GET /category_keywords
  # GET /category_keywords.json
  def index
    @category_keywords = CategoryKeyword.all
    session[:pagetobeloaded]= "category_edit"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_keywords }
    end
  end

  # GET /category_keywords/1
  # GET /category_keywords/1.json
  def show
  	session[:pagetobeloaded]= "category_edit"
    @category_keyword = CategoryKeyword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_keyword }
    end
  end

  # GET /category_keywords/new
  # GET /category_keywords/new.json
  def new
    @category_keyword = CategoryKeyword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_keyword }
    end
  end

  # GET /category_keywords/1/edit
  def edit
  	session[:pagetobeloaded]= "category_edit"
    @category_keyword = CategoryKeyword.find(params[:id])
  end

  # POST /category_keywords
  # POST /category_keywords.json
  def create
    @category_keyword = CategoryKeyword.new(params[:category_keyword])

    respond_to do |format|
      if @category_keyword.save
        format.html { redirect_to @category_keyword, notice: 'Category keyword was successfully created.' }
        format.json { render json: @category_keyword, status: :created, location: @category_keyword }
      else
        format.html { render action: "new" }
        format.json { render json: @category_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /category_keywords/1
  # PUT /category_keywords/1.json
  def update
    @category_keyword = CategoryKeyword.find(params[:id])

    respond_to do |format|
      if @category_keyword.update_attributes(params[:category_keyword])
        format.html { redirect_to @category_keyword, notice: 'Category keyword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_keywords/1
  # DELETE /category_keywords/1.json
  def destroy
    @category_keyword = CategoryKeyword.find(params[:id])
    @category_keyword.destroy

    respond_to do |format|
      format.html { redirect_to category_keywords_url }
      format.json { head :no_content }
    end
  end
end

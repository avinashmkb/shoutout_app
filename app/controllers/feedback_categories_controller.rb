class FeedbackCategoriesController < ApplicationController
  # GET /feedback_categories
  # GET /feedback_categories.json
  def index
    @feedback_categories = FeedbackCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedback_categories }
    end
  end

  # GET /feedback_categories/1
  # GET /feedback_categories/1.json
  def show
    @feedback_category = FeedbackCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback_category }
    end
  end

  # GET /feedback_categories/new
  # GET /feedback_categories/new.json
  def new
    @feedback_category = FeedbackCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback_category }
    end
  end

  # GET /feedback_categories/1/edit
  def edit
    @feedback_category = FeedbackCategory.find(params[:id])
  end

  # POST /feedback_categories
  # POST /feedback_categories.json
  def create
    @feedback_category = FeedbackCategory.new(params[:feedback_category])

    respond_to do |format|
      if @feedback_category.save
        format.html { redirect_to @feedback_category, notice: 'Feedback category was successfully created.' }
        format.json { render json: @feedback_category, status: :created, location: @feedback_category }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feedback_categories/1
  # PUT /feedback_categories/1.json
  def update
    @feedback_category = FeedbackCategory.find(params[:id])

    respond_to do |format|
      if @feedback_category.update_attributes(params[:feedback_category])
        format.html { redirect_to @feedback_category, notice: 'Feedback category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedback_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedback_categories/1
  # DELETE /feedback_categories/1.json
  def destroy
    @feedback_category = FeedbackCategory.find(params[:id])
    @feedback_category.destroy

    respond_to do |format|
      format.html { redirect_to feedback_categories_url }
      format.json { head :no_content }
    end
  end
end

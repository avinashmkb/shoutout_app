class SentimentOveridesController < ApplicationController
  # GET /sentiment_overides
  # GET /sentiment_overides.json
  def index
    @sentiment_overides = SentimentOveride.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sentiment_overides }
    end
  end

  # GET /sentiment_overides/1
  # GET /sentiment_overides/1.json
  def show
    @sentiment_overide = SentimentOveride.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sentiment_overide }
    end
  end

  # GET /sentiment_overides/new
  # GET /sentiment_overides/new.json
  def new
    @sentiment_overide = SentimentOveride.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sentiment_overide }
    end
  end

  # GET /sentiment_overides/1/edit
  def edit
    @sentiment_overide = SentimentOveride.find(params[:id])
  end

  # POST /sentiment_overides
  # POST /sentiment_overides.json
  def create
    @sentiment_overide = SentimentOveride.new(params[:sentiment_overide])

    respond_to do |format|
      if @sentiment_overide.save
        format.html { redirect_to @sentiment_overide, notice: 'Sentiment overide was successfully created.' }
        format.json { render json: @sentiment_overide, status: :created, location: @sentiment_overide }
      else
        format.html { render action: "new" }
        format.json { render json: @sentiment_overide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sentiment_overides/1
  # PUT /sentiment_overides/1.json
  def update
    @sentiment_overide = SentimentOveride.find(params[:id])

    respond_to do |format|
      if @sentiment_overide.update_attributes(params[:sentiment_overide])
        format.html { redirect_to @sentiment_overide, notice: 'Sentiment overide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sentiment_overide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentiment_overides/1
  # DELETE /sentiment_overides/1.json
  def destroy
    @sentiment_overide = SentimentOveride.find(params[:id])
    @sentiment_overide.destroy

    respond_to do |format|
      format.html { redirect_to sentiment_overides_url }
      format.json { head :no_content }
    end
  end
end

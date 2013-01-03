class SentimentOverridesController < ApplicationController
  # GET /sentiment_overrides
  # GET /sentiment_overrides.json
  def index
    @sentiment_overrides = SentimentOverride.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sentiment_overrides }
    end
  end

  # GET /sentiment_overrides/1
  # GET /sentiment_overrides/1.json
  def show
    @sentiment_override = SentimentOverride.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sentiment_override }
    end
  end

  # GET /sentiment_overrides/new
  # GET /sentiment_overrides/new.json
  def new
    @sentiment_override = SentimentOverride.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sentiment_override }
    end
  end

  # GET /sentiment_overrides/1/edit
  def edit
    @sentiment_override = SentimentOverride.find(params[:id])
  end

  # POST /sentiment_overrides
  # POST /sentiment_overrides.json
  def create
    @sentiment_override = SentimentOverride.new(params[:sentiment_override])

    respond_to do |format|
      if @sentiment_override.save
        format.html { redirect_to @sentiment_override, notice: 'Sentiment override was successfully created.' }
        format.json { render json: @sentiment_override, status: :created, location: @sentiment_override }
      else
        format.html { render action: "new" }
        format.json { render json: @sentiment_override.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sentiment_overrides/1
  # PUT /sentiment_overrides/1.json
  def update
    @sentiment_override = SentimentOverride.find(params[:id])

    respond_to do |format|
      if @sentiment_override.update_attributes(params[:sentiment_override])
        format.html { redirect_to @sentiment_override, notice: 'Sentiment override was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sentiment_override.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentiment_overrides/1
  # DELETE /sentiment_overrides/1.json
  def destroy
    @sentiment_override = SentimentOverride.find(params[:id])
    @sentiment_override.destroy

    respond_to do |format|
      format.html { redirect_to sentiment_overrides_url }
      format.json { head :no_content }
    end
  end
end

class SentimentsController < ApplicationController
  # GET /sentiments
  # GET /sentiments.json
  def index
    @sentiments = Sentiment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sentiments }
    end
  end

  # GET /sentiments/1
  # GET /sentiments/1.json
  def show
    @sentiment = Sentiment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sentiment }
    end
  end

  # GET /sentiments/new
  # GET /sentiments/new.json
  def new
    @sentiment = Sentiment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sentiment }
    end
  end

  # GET /sentiments/1/edit
  def edit
    @sentiment = Sentiment.find(params[:id])
  end

  # POST /sentiments
  # POST /sentiments.json
  def create
    @sentiment = Sentiment.new(params[:sentiment])

    respond_to do |format|
      if @sentiment.save
        format.html { redirect_to @sentiment, notice: 'Sentiment was successfully created.' }
        format.json { render json: @sentiment, status: :created, location: @sentiment }
      else
        format.html { render action: "new" }
        format.json { render json: @sentiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sentiments/1
  # PUT /sentiments/1.json
  def update
    @sentiment = Sentiment.find(params[:id])

    respond_to do |format|
      if @sentiment.update_attributes(params[:sentiment])
        format.html { redirect_to @sentiment, notice: 'Sentiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sentiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentiments/1
  # DELETE /sentiments/1.json
  def destroy
    @sentiment = Sentiment.find(params[:id])
    @sentiment.destroy

    respond_to do |format|
      format.html { redirect_to sentiments_url }
      format.json { head :no_content }
    end
  end
end

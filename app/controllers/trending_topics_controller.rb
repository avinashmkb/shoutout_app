class TrendingTopicsController < ApplicationController
  # GET /trending_topics
  # GET /trending_topics.json
  def index
    @trending_topics = TrendingTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trending_topics }
    end
  end

  # GET /trending_topics/1
  # GET /trending_topics/1.json
  def show
    @trending_topic = TrendingTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trending_topic }
    end
  end

  # GET /trending_topics/new
  # GET /trending_topics/new.json
  def new
    @trending_topic = TrendingTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trending_topic }
    end
  end

  # GET /trending_topics/1/edit
  def edit
    @trending_topic = TrendingTopic.find(params[:id])
  end

  # POST /trending_topics
  # POST /trending_topics.json
  def create
    @trending_topic = TrendingTopic.new(params[:trending_topic])

    respond_to do |format|
      if @trending_topic.save
        format.html { redirect_to @trending_topic, notice: 'Trending topic was successfully created.' }
        format.json { render json: @trending_topic, status: :created, location: @trending_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @trending_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trending_topics/1
  # PUT /trending_topics/1.json
  def update
    @trending_topic = TrendingTopic.find(params[:id])

    respond_to do |format|
      if @trending_topic.update_attributes(params[:trending_topic])
        format.html { redirect_to @trending_topic, notice: 'Trending topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trending_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trending_topics/1
  # DELETE /trending_topics/1.json
  def destroy
    @trending_topic = TrendingTopic.find(params[:id])
    @trending_topic.destroy

    respond_to do |format|
      format.html { redirect_to trending_topics_url }
      format.json { head :no_content }
    end
  end
end

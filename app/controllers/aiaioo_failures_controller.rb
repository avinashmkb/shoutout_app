class AiaiooFailuresController < ApplicationController
  # GET /aiaioo_failures
  # GET /aiaioo_failures.json
  def index
    @aiaioo_failures = AiaiooFailure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aiaioo_failures }
    end
  end

  # GET /aiaioo_failures/1
  # GET /aiaioo_failures/1.json
  def show
    @aiaioo_failure = AiaiooFailure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aiaioo_failure }
    end
  end

  # GET /aiaioo_failures/new
  # GET /aiaioo_failures/new.json
  def new
    @aiaioo_failure = AiaiooFailure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aiaioo_failure }
    end
  end

  # GET /aiaioo_failures/1/edit
  def edit
    @aiaioo_failure = AiaiooFailure.find(params[:id])
  end

  # POST /aiaioo_failures
  # POST /aiaioo_failures.json
  def create
    @aiaioo_failure = AiaiooFailure.new(params[:aiaioo_failure])

    respond_to do |format|
      if @aiaioo_failure.save
        format.html { redirect_to @aiaioo_failure, notice: 'Aiaioo failure was successfully created.' }
        format.json { render json: @aiaioo_failure, status: :created, location: @aiaioo_failure }
      else
        format.html { render action: "new" }
        format.json { render json: @aiaioo_failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aiaioo_failures/1
  # PUT /aiaioo_failures/1.json
  def update
    @aiaioo_failure = AiaiooFailure.find(params[:id])

    respond_to do |format|
      if @aiaioo_failure.update_attributes(params[:aiaioo_failure])
        format.html { redirect_to @aiaioo_failure, notice: 'Aiaioo failure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aiaioo_failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aiaioo_failures/1
  # DELETE /aiaioo_failures/1.json
  def destroy
    @aiaioo_failure = AiaiooFailure.find(params[:id])
    @aiaioo_failure.destroy

    respond_to do |format|
      format.html { redirect_to aiaioo_failures_url }
      format.json { head :no_content }
    end
  end
end

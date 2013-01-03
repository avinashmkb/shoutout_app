class SmsLingosController < ApplicationController
  # GET /sms_lingos
  # GET /sms_lingos.json
  def index
    @sms_lingos = SmsLingo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_lingos }
    end
  end

  # GET /sms_lingos/1
  # GET /sms_lingos/1.json
  def show
    @sms_lingo = SmsLingo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms_lingo }
    end
  end

  # GET /sms_lingos/new
  # GET /sms_lingos/new.json
  def new
    @sms_lingo = SmsLingo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms_lingo }
    end
  end

  # GET /sms_lingos/1/edit
  def edit
    @sms_lingo = SmsLingo.find(params[:id])
  end

  # POST /sms_lingos
  # POST /sms_lingos.json
  def create
    @sms_lingo = SmsLingo.new(params[:sms_lingo])

    respond_to do |format|
      if @sms_lingo.save
        format.html { redirect_to @sms_lingo, notice: 'Sms lingo was successfully created.' }
        format.json { render json: @sms_lingo, status: :created, location: @sms_lingo }
      else
        format.html { render action: "new" }
        format.json { render json: @sms_lingo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sms_lingos/1
  # PUT /sms_lingos/1.json
  def update
    @sms_lingo = SmsLingo.find(params[:id])

    respond_to do |format|
      if @sms_lingo.update_attributes(params[:sms_lingo])
        format.html { redirect_to @sms_lingo, notice: 'Sms lingo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms_lingo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_lingos/1
  # DELETE /sms_lingos/1.json
  def destroy
    @sms_lingo = SmsLingo.find(params[:id])
    @sms_lingo.destroy

    respond_to do |format|
      format.html { redirect_to sms_lingos_url }
      format.json { head :no_content }
    end
  end
end

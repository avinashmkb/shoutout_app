class IncomingMessageLogsController < ApplicationController
  # GET /incoming_message_logs
  # GET /incoming_message_logs.json
  def index
    @incoming_message_logs = IncomingMessageLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incoming_message_logs }
    end
  end

  # GET /incoming_message_logs/1
  # GET /incoming_message_logs/1.json
  def show
    @incoming_message_log = IncomingMessageLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @incoming_message_log }
    end
  end

  # GET /incoming_message_logs/new
  # GET /incoming_message_logs/new.json
  def new
    @incoming_message_log = IncomingMessageLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @incoming_message_log }
    end
  end

  # GET /incoming_message_logs/1/edit
  def edit
    @incoming_message_log = IncomingMessageLog.find(params[:id])
  end

  # POST /incoming_message_logs
  # POST /incoming_message_logs.json
  def create
    @incoming_message_log = IncomingMessageLog.new(params[:incoming_message_log])

    respond_to do |format|
      if @incoming_message_log.save
        format.html { redirect_to @incoming_message_log, notice: 'Incoming message log was successfully created.' }
        format.json { render json: @incoming_message_log, status: :created, location: @incoming_message_log }
      else
        format.html { render action: "new" }
        format.json { render json: @incoming_message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /incoming_message_logs/1
  # PUT /incoming_message_logs/1.json
  def update
    @incoming_message_log = IncomingMessageLog.find(params[:id])

    respond_to do |format|
      if @incoming_message_log.update_attributes(params[:incoming_message_log])
        format.html { redirect_to @incoming_message_log, notice: 'Incoming message log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @incoming_message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incoming_message_logs/1
  # DELETE /incoming_message_logs/1.json
  def destroy
    @incoming_message_log = IncomingMessageLog.find(params[:id])
    @incoming_message_log.destroy

    respond_to do |format|
      format.html { redirect_to incoming_message_logs_url }
      format.json { head :no_content }
    end
  end
end

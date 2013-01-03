class OutgoingMessageLogsController < ApplicationController
  # GET /outgoing_message_logs
  # GET /outgoing_message_logs.json
  def index
    @outgoing_message_logs = OutgoingMessageLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outgoing_message_logs }
    end
  end

  # GET /outgoing_message_logs/1
  # GET /outgoing_message_logs/1.json
  def show
    @outgoing_message_log = OutgoingMessageLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outgoing_message_log }
    end
  end

  # GET /outgoing_message_logs/new
  # GET /outgoing_message_logs/new.json
  def new
    @outgoing_message_log = OutgoingMessageLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outgoing_message_log }
    end
  end

  # GET /outgoing_message_logs/1/edit
  def edit
    @outgoing_message_log = OutgoingMessageLog.find(params[:id])
  end

  # POST /outgoing_message_logs
  # POST /outgoing_message_logs.json
  def create
    @outgoing_message_log = OutgoingMessageLog.new(params[:outgoing_message_log])

    respond_to do |format|
      if @outgoing_message_log.save
        format.html { redirect_to @outgoing_message_log, notice: 'Outgoing message log was successfully created.' }
        format.json { render json: @outgoing_message_log, status: :created, location: @outgoing_message_log }
      else
        format.html { render action: "new" }
        format.json { render json: @outgoing_message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /outgoing_message_logs/1
  # PUT /outgoing_message_logs/1.json
  def update
    @outgoing_message_log = OutgoingMessageLog.find(params[:id])

    respond_to do |format|
      if @outgoing_message_log.update_attributes(params[:outgoing_message_log])
        format.html { redirect_to @outgoing_message_log, notice: 'Outgoing message log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @outgoing_message_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outgoing_message_logs/1
  # DELETE /outgoing_message_logs/1.json
  def destroy
    @outgoing_message_log = OutgoingMessageLog.find(params[:id])
    @outgoing_message_log.destroy

    respond_to do |format|
      format.html { redirect_to outgoing_message_logs_url }
      format.json { head :no_content }
    end
  end
end

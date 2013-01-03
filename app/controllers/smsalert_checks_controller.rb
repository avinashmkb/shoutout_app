class SmsalertChecksController < ApplicationController
  # GET /smsalert_checks
  # GET /smsalert_checks.json
  def index
    @smsalert_checks = SmsalertCheck.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @smsalert_checks }
    end
  end

  # GET /smsalert_checks/1
  # GET /smsalert_checks/1.json
  def show
    @smsalert_check = SmsalertCheck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @smsalert_check }
    end
  end

  # GET /smsalert_checks/new
  # GET /smsalert_checks/new.json
  def new
    @smsalert_check = SmsalertCheck.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @smsalert_check }
    end
  end

  # GET /smsalert_checks/1/edit
  def edit
    @smsalert_check = SmsalertCheck.find(params[:id])
  end

  # POST /smsalert_checks
  # POST /smsalert_checks.json
  def create
    @smsalert_check = SmsalertCheck.new(params[:smsalert_check])

    respond_to do |format|
      if @smsalert_check.save
        format.html { redirect_to @smsalert_check, notice: 'Smsalert check was successfully created.' }
        format.json { render json: @smsalert_check, status: :created, location: @smsalert_check }
      else
        format.html { render action: "new" }
        format.json { render json: @smsalert_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /smsalert_checks/1
  # PUT /smsalert_checks/1.json
  def update
    @smsalert_check = SmsalertCheck.find(params[:id])

    respond_to do |format|
      if @smsalert_check.update_attributes(params[:smsalert_check])
        format.html { redirect_to @smsalert_check, notice: 'Smsalert check was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @smsalert_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smsalert_checks/1
  # DELETE /smsalert_checks/1.json
  def destroy
    @smsalert_check = SmsalertCheck.find(params[:id])
    @smsalert_check.destroy

    respond_to do |format|
      format.html { redirect_to smsalert_checks_url }
      format.json { head :no_content }
    end
  end
end

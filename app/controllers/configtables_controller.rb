class ConfigtablesController < ApplicationController
  # GET /configtables
  # GET /configtables.json
  def index
    @configtables = Configtable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @configtables }
    end
  end

  # GET /configtables/1
  # GET /configtables/1.json
  def show
    @configtable = Configtable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @configtable }
    end
  end

  # GET /configtables/new
  # GET /configtables/new.json
  def new
    @configtable = Configtable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @configtable }
    end
  end

  # GET /configtables/1/edit
  def edit
    @configtable = Configtable.find(params[:id])
  end

  # POST /configtables
  # POST /configtables.json
  def create
    @configtable = Configtable.new(params[:configtable])

    respond_to do |format|
      if @configtable.save
        format.html { redirect_to @configtable, notice: 'Configtable was successfully created.' }
        format.json { render json: @configtable, status: :created, location: @configtable }
      else
        format.html { render action: "new" }
        format.json { render json: @configtable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /configtables/1
  # PUT /configtables/1.json
  def update
    @configtable = Configtable.find(params[:id])

    respond_to do |format|
      if @configtable.update_attributes(params[:configtable])
        format.html { redirect_to @configtable, notice: 'Configtable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @configtable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /configtables/1
  # DELETE /configtables/1.json
  def destroy
    @configtable = Configtable.find(params[:id])
    @configtable.destroy

    respond_to do |format|
      format.html { redirect_to configtables_url }
      format.json { head :no_content }
    end
  end
end

class McouponsController < ApplicationController
  # GET /mcoupons
  # GET /mcoupons.json
  def index
    @mcoupons = Mcoupon.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mcoupons }
    end
  end

  # GET /mcoupons/1
  # GET /mcoupons/1.json
  def show
    @mcoupon = Mcoupon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mcoupon }
    end
  end

  # GET /mcoupons/new
  # GET /mcoupons/new.json
  def new
    @mcoupon = Mcoupon.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mcoupon }
    end
  end

  # GET /mcoupons/1/edit
  def edit
    @mcoupon = Mcoupon.find(params[:id])
  end

  # POST /mcoupons
  # POST /mcoupons.json
  def create
    @mcoupon = Mcoupon.new(params[:mcoupon])

    respond_to do |format|
      if @mcoupon.save
        format.html { redirect_to @mcoupon, notice: 'Mcoupon was successfully created.' }
        format.json { render json: @mcoupon, status: :created, location: @mcoupon }
      else
        format.html { render action: "new" }
        format.json { render json: @mcoupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mcoupons/1
  # PUT /mcoupons/1.json
  def update
    @mcoupon = Mcoupon.find(params[:id])

    respond_to do |format|
      if @mcoupon.update_attributes(params[:mcoupon])
        format.html { redirect_to @mcoupon, notice: 'Mcoupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mcoupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mcoupons/1
  # DELETE /mcoupons/1.json
  def destroy
    @mcoupon = Mcoupon.find(params[:id])
    @mcoupon.destroy

    respond_to do |format|
      format.html { redirect_to mcoupons_url }
      format.json { head :no_content }
    end
  end
end

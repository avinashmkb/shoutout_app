class SessionController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
  	
  	# get hostname or ip adress 
  	ipaddress=server_ipaddress()
  	baseurl = "http://" + ipaddress +"/dashboard"
  	business_id = session[:user_id]
  	if business = Business.authenticate(params[:login_id], params[:password])
  		session[:user_id] = business.id
  		lastmonth = DateTime.now - 1.month
         today =DateTime.now
  		session[:fromdate]=lastmonth.strftime("%d-%m-%Y")
  		session[:todate]=today.strftime("%d-%m-%Y")
		redirect_to "/dashboard/feedbacks/"	
  	else
  		url = baseurl + "/?&invalidpwd=incorrectpassword"
  		redirect_to url, :alert => "Invalid user/password combination"
  	end
  end

  def destroy
  	ipaddress=server_ipaddress()
  	baseurl = "http://" + ipaddress +"/dashboard"
  	business_id = session[:user_id]
  	session[:user_id] = nil
  	url= baseurl + "/?&logout=loggedout"
  	redirect_to url, :notice => "Logged Out"
  end
  
  
end

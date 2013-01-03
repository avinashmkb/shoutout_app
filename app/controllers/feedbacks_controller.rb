require 'date'
require "socket"

class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  
  def getDashboardHeading
  	
  	# get hostname or ip adress 
  	ipaddress=server_ipaddress()
  	@baseurl = "http://" + ipaddress +"/dashboard"
  	business_id = session[:user_id]
  	# Fetch Login_ID to use in dashboard heading.
  	businessrecord = Business.find(business_id)
  	@login_name=businessrecord.login_id 
  	
  	
    branch_detail = Branch.where ("business_id='#{business_id}'")
    
        
    # get all cities in table corresponding to the Business_Id for dropdown
        	 
    @cityname = branch_detail.map{|t| t.city}.uniq
    @cityname.insert(0,"City")	
    
    # populate all branches to query for initial dashboard without City and Store selection
    branch_list =[]
    branch_detail.each do |branchrecord|
    		branch_list << branchrecord.id
    end 		
    
    if params[:city]
    	session[:city_id]= params[:city]
    end 
    
    if params[:store]
    	session[:store_id]= params[:store]
    end 	   	
    
    # Initialize the array so that the comboworks on reload
    # if params[:city] and params[:city]!="City"	
      if session[:city_id]!="City"
      	#session[:city_id]= params[:city]
    	@cityname.delete("City")
    	@cityname.delete(session[:city_id])
    	@cityname.insert( 0, session[:city_id] ) 
    end	
    
    
    	
    
   # Get all store list in case City has been selected by user
    
    @storename=[]
    branchcitywise =[]
    singlestorebranch_id =0
    if session[:city_id] != "City"
    	branch_detail.each do |branchrecord|
    			if branchrecord.city == session[:city_id] 
    			@storename << branchrecord.address_lane2
    			branchcitywise << branchrecord.id
			  	if branchrecord.address_lane2 == session[:store_id]
					singlestorebranch_id= branchrecord.id
				end	
    		end 	
    	end	
    	@storename.insert(0,"Store") # Initialize the dropdown with Store value at start so that Jquery Combox works
    else 
    	@storename << "Store" # Initialize the dropdown with Store value
    end 
        
    # Initialize the array so that the comboworks on reload    
   if  session[:store_id] !="Store"
     
    	#session[:store_id]= params[:store]
    	deletesucess=@storename.delete(session[:store_id])
    	if deletesucess
    		 @storename.insert( 0, session[:store_id])
    	end	 
    	@storename.delete("Store")
    	@storename.compact!
    end	
    
    #Initialize score or read it from the get URL encoded form.
    if params[:fromdate] and params[:todate]
    	session[:fromdate]=params[:fromdate]
    	session[:todate] =params[:todate]
    end 	
  
    @fromdate = Date.strptime(session[:fromdate], '%d-%m-%Y')
    #lastmonth = DateTime.now - 1.month
    @todate = Date.strptime(session[:todate], '%d-%m-%Y')
       
   @branchlistquery = [] 
   if session[:city_id]=="City" and session[:store_id]=="Store"
   	  @branchlistquery =branch_list
   elsif session[:city_id]!="City" and session[:store_id]=="Store"
   	  @branchlistquery=branchcitywise
   else
   	  @branchlistquery << singlestorebranch_id
   end 	    	  
  
   
  		
  end  
  
  def frequentWords
  	
  	# Fetch Frequently occuring keywords 
  	begin
  	@repeat_keywords =TrendingTopic.find_by_sql(["select text , COUNT(text)as count,SUM(sentiment_score)as score FROM trending_topics where created_at >= ? and created_at <= ? and branch_id IN (?)  group by text  order by COUNT(text) DESC LIMIT 10;",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery])
  	rescue ActiveRecord::RecordNotFound
  		@repeat_keywords =[]
  	end 
  	
  	
  	
  	
  end
  
  
  def getNetScore
  	# Function to fetch the Netscore corresponding to the selection in combobox  	
  score =Feedback.average(:sentiment_score, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN (?)",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery])             
  
  # Ensure that the netscore is set to zero in case no records are matching it.
  if score != nil 
         	@netscore = score.ceil
         else 
         	@netscore = 0
  end 	
  	
  end 	
 # Function to Initialize PieChart details .
  
 def getPieChartDetails
 	
 	 # Query the Table to perform the average netscore calcuations based on selections in combobox
   
  	sentimentarray=[1,2]
				@piechartPositive =Feedback.count(:all, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN (?) and sentiment_id IN (?)",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray]) 	
	sentimentarray=[4,5]
				@piechartNegative =Feedback.count(:all, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN (?) and sentiment_id IN (?)",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray])			
   sentimentarray=[3]
				@piechartNeutral =Feedback.count(:all, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN (?) and sentiment_id IN (?)",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray])				
 
 	
 	
 end 
 
 # Fill data for the ready made classifications
 def getReadyMadeClassifications
    
    # Query the table for Service -Positive , Negative and Neutral comments with hardcoded categories
    # Later figure out the dynamic logic for determin number of facets to be tracked.
   
    @smscount=[]
    # Fetch Category id based on business id
    businessid = session[:user_id]
    category_records = Category.find(:all,:conditions=>["business_id=?",businessid])
    @categorynames =[]
    @business_categoryids=[]
    
    category_records.each do |category_record|
     categoryid = category_record.id 	
     @business_categoryids<<category_record.id
     # Store category id and name for use in view
     @categorynames << category_record.name
 	   sentimentarray =[1,2]
 	   tempresult= Feedback.count :conditions => ["feedback_categories.category_id = ? and feedback_categories.created_at >= ? and feedback_categories.created_at <= ? and feedback_categories.branch_id IN(?) and feedbacks.sentiment_id IN(?)",categoryid,@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray], :joins => "INNER JOIN feedback_categories ON feedbacks.id=feedback_categories.feedback_id"
       @smscount << tempresult
       
  	  sentimentarray =[4,5]
  	  tempresult= Feedback.count :conditions => ["feedback_categories.category_id = ? and feedback_categories.created_at >= ? and feedback_categories.created_at <= ? and feedback_categories.branch_id IN(?) and feedbacks.sentiment_id IN(?)",categoryid,@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray], :joins => "INNER JOIN feedback_categories ON feedbacks.id=feedback_categories.feedback_id"
  	  
       @smscount << tempresult
  	 	 sentimentarray =[3]
   		 tempresult= Feedback.count :conditions => ["feedback_categories.category_id = ? and feedback_categories.created_at >= ? and feedback_categories.created_at <= ? and feedback_categories.branch_id IN(?) and feedbacks.sentiment_id IN(?)",categoryid,@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery,sentimentarray], :joins => "INNER JOIN feedback_categories ON feedbacks.id=feedback_categories.feedback_id"
   		 @smscount << tempresult
  		 
    end
    
      
    
 end
 
 # Function to Initialize Experience Score tracker
 
 
 def getExperienceScoreDetails
 # Charting for experience score tracker
  	    
 
 # Charting for experience score tracker
  	# Determine Date range  < 30 days then set the range to daily else need weekly
  	# Set Chart mode to daily else it will be weekly	
  		session[:chartmode] ="daily"  	 
  		numofsmses=[]
  		overall_netscore=[]
  		 
  			
  	 @fromdate.to_date.upto(@todate.to_date) do |day|
  			
    			smscount = Feedback.count(:all,:conditions =>["created_at >= ? and created_at <= ? and branch_id IN(?)",day.beginning_of_day, day.end_of_day,@branchlistquery])
    		        smsstring_partone= "{x:Date.UTC("
                        
                        smsstring_year=day.strftime("%Y,")
                        smsstring_month = day.month-1
                        smsstring_day = day.strftime(",%d")
                        smsstring_parttwo = smsstring_year + smsstring_month.to_s()+ smsstring_day
                        smsstring_partthree ="),y:" + smscount.to_s()
                        smsstring_final = smsstring_partone + smsstring_parttwo +smsstring_partthree +"}"
    		        numofsmses << smsstring_final	
    			# Query the Netscore on a daily basis   			
    			
    			tempresult= Feedback.average(:sentiment_score, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN(?)",day.beginning_of_day, day.end_of_day,@branchlistquery])
    			if tempresult != nil 
         			netscore_temp = tempresult.ceil
        		else 
         			netscore_temp = 0
                 end
                 smsstring_partthree ="),y:" + netscore_temp.to_s()
                 servicestring_final = smsstring_partone + smsstring_parttwo +smsstring_partthree +"}"
 	
                 overall_netscore << servicestring_final 
    			
    			
  		
  		end
  		
  		@smsdataseries=numofsmses.join(",")
  		@netscore_dataseries=overall_netscore.join(",")
  		
  	
 	


	
 end 	
   
 	
  	    
 	
 
 
  	
  
  def index
  	
  	session[:pagetobeloaded]="dashboard"
  	session[:city_id] = "City"
  	session[:store_id]="Store"
    
  	
  	getDashboardHeading()
    
    getExperienceScoreDetails()
    getNetScore()
    frequentWords()
    getReadyMadeClassifications()
  	
  	     
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  	
  	session[:pagetobeloaded]=""
    #@feedback = Feedback.find(params[:id])
   # session[:city_id] = "City"
   #session[:store_id]="Store"
    # Get the Dashboard headings
    getDashboardHeading()
    
    		
  if params[:id] == "feedback"
  	  	
  	getNetScore()
  	session[:feedbacktype]="all"
  	session[:pagetobeloaded]="feedback" 
    # Get feedback related to the branches which are related to Businness.
   @feedbacks =Feedback.find(:all, :conditions => ["created_at >= ? and created_at <= ? and branch_id IN (?)",@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery], :order => "created_at DESC")
   
   getPieChartDetails()
  
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
     end  
       
   elsif params[:id]=="category"
   	
   	session[:pagetobeloaded]="category" 
   	
   	if params[:feedbacktype].present?
   		session[:feedbacktype]=params[:feedbacktype]
   	end 	
   	
   	if params[:category].present?
    session[:category] = params[:category]
   end
   	
   	
   	# Fetch Category Name from Categories Table so that we can display inside Drilldown
   	  
   	  category_id = session[:category]
   	  category_record = Category.find(category_id)
   		session[:categoryname]=category_record.name
    
   	
   	@feedbacks= Feedback.find(:all,:conditions => ["feedback_categories.category_id = ? and feedback_categories.created_at >= ? and feedback_categories.created_at <= ? and feedback_categories.branch_id IN(?)",session[:category],@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery], :joins => "INNER JOIN feedback_categories ON feedbacks.id=feedback_categories.feedback_id", :order => "created_at DESC")
   	
   	respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
     end
   	
   elsif params[:id]=="frequentwords"
   	    frequentWords()
  		 session[:pagetobeloaded]="frequentwords"	
 	  if params[:keyword].present?
  		  session[:keyword] = params[:keyword]
  	 end
   		session[:feedbacktype]="all"		 
  		  # Get feedback related to the branches which are related to Businness.
  		 #@feedbacks =Feedback.where("message LIKE '%#{params[:keyword]}%'")
  		 topic = session[:keyword]
  		 # Fetch the Trending topic id and matching FeedbackId
  		# topic_ids = TrendingTopic.find(:all, :conditions=> ["trending_topics.text=? and trending_topics.created_at >= ? and trending_topics.created_at <= ? and trending_topics.branch_id IN (?)",topic,@fromdate.beginning_of_day,@todate.end_of_day,@branchlistquery],:order => "created_at DESC")
         # Fetching feedback_id containing keyword and matching filter.              		
          topic_ids=TrendingTopic.find_by_sql(["select * from trending_topics INNER JOIN feedback_topics ON trending_topics.id=feedback_topics.trendingtopic_id where text=? and trending_topics.branch_id IN(?) and trending_topics.created_at >= ? and trending_topics.created_at <= ?",topic,@branchlistquery, @fromdate.beginning_of_day,@todate.end_of_day])           		 
  		
  		 # Fetch all feedback id's matching the keyword 		 
  		 feedback_match =[]
  		 
  		 topic_ids.each do |topic|
  		 	feedback_match << topic.feedback_id
  		 end 	
  		  		 
  		 
  		@feedbacks =Feedback.find(:all,:conditions=> ["id IN(?)",feedback_match] )
   		
  
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
     end  
   end	
       
  # End of query for Feedbacks Table.
    
    
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end
end

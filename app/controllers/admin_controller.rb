class AdminController < ApplicationController
require 'rest_client' 
require 'crack/xml'
require 'spellcheck2.rb'
require 'uri' 
require 'andand'
require 'stanford-core-nlp'
skip_before_filter :authorize
 def index
   # @messages_received = Feedback.count
   # redirect_to "http://shoppersays.com/dashboard/"
   
       if params[:id] != "unicel"
           redirect_to "http://shoppersays.com/dashboard/"   
        elsif 
         session[:pagetobeloaded]="shoppersaysapi"
         # Initialize a Rails loggger to point a a log file for Feedback Application & Feedback Thread indentifier
        @logger = Logger.new('SMSFeedbaclApp.log')
        @threadnumber = Random.rand(99999)
        
        
    	 result_intitalize= initializeRequestData()
     		if result_intitalize == 0
   							general_failure_message = Configtable.find_by_name_and_business_id('blankincomingmessage',@business_id).value
   							@datetime = Time.now.inspect
   							@logger.info "#{@datetime} <#{@threadnumber}>  Unicel Error occured either message is blank or Unicel did not sent the correct params"
                #sendUnicelMessage(general_failure_message,@sendernumber)
                @api_response= general_failure_message
                return
                         
        end  
             
        #Fetch Business Id based on vnumber
            begin
                	  @business_record = Business.find_by_unicel_vnumber!(@virtualnumber)
              			rescue ActiveRecord::RecordNotFound
              			  @logger.info "#{@datetime} <#{@threadnumber}> Sending General Failure message . Could not map vnumber to Business"
              			  # Query general failure message for business_id =1
              			  @business_id =1
              	  		general_failure_message = Configtable.find_by_name_and_business_id('general_failure',1).value
                 			sendUnicelMessage(general_failure_message,@sendernumber)
                  		@api_response= general_failure_message
                  		return
            end
        # Initialize Business Id for fetching config date    
        @business_id = @business_record.id
        @logger.info "#{@datetime} <#{@threadnumber}>  Determined Business Id based on Vnumber #{@business_id}"

                
        
        
        # Update incoming message into incoming_logs table
        incominglog =IncomingMessageLog.create(:message=> @usermessage,:mobile_number=>@sendernumber)
        @datetime = Time.now.inspect
        @logger.info "#{@datetime} <#{@threadnumber}> Recieved incoming message text: < #{@usermessage} >from phone number <#{@sendernumber}>"
         	
        # Update sender number into users table and store the id for later use
         usernumber = User.where(:mobile_number=>@sendernumber).first_or_create!(:mobile_number=>@sendernumber)
     
        
     
     
        # Extract keyword from SMS recieved 
        prefix_keyword= first_x_words(@usermessage,1,"")
        @datetime = Time.now.inspect
        @logger.info "#{@datetime} <#{@threadnumber}> Extracted prefix keyword <#{prefix_keyword}>"
       
       
        
        # Match the keyword inside keywords table to see if we can map to branch and business

          begin  # Begin block for Rescue for Activ_Record_Not_Found
              keywordBranch = Keyword.find_by_keyword!(prefix_keyword)
              rescue ActiveRecord::RecordNotFound
                @logger.info "#{@datetime} <#{@threadnumber}>  Prefix match not found in DB for <#{prefix_keyword}> starting handling"
                keyword_not_found= 1
          end   
          
          if keyword_not_found ==1
                #  Fetch default branch and city based on business Id
                branches_record_match = Branch.find_by_business_id_and_city(@business_record.id,"Unassigned")
                @logger.info "#{@datetime} <#{@threadnumber}>  Searching for Unassigned city  and store for business id"
          else 
                branches_record_match = Branch.find(keywordBranch.branch_id)
          end 
                                
              
                
        
       # Process the incoming message by calling Aiaioo and standford parser
    
        # Strip prefix_keyword 
        if keyword_not_found !=1
          usermessage_wo_prefix = @usermessage.sub(prefix_keyword,"")
        else
           usermessage_wo_prefix =@usermessage
        end 
       
        
       
       # Check if Message is blank  after keyword and respond with error message
         # Remove all spaces from user message
         usermessage_no_spaces =usermessage_wo_prefix.gsub(" ","")
         if  usermessage_no_spaces ==""
                blank_incoming_message = Configtable.find_by_name_and_business_id('blankincomingmessage',@business_id).value
                sendUnicelMessage(blank_incoming_message,@sendernumber)
                @logger.info "#{@datetime} <#{@threadnumber}>  User sent blank message after Keyword. Only keyword recieved"
                @api_response = blank_incoming_message
                return
         end 
       
       
          
        # Padded with blanks and beginning and end  
          usermessage_modified= " " + usermessage_wo_prefix + " "
          
       # Remove special characters from message and replace with white spaces

          usermessage_no_spchar = usermessage_wo_prefix.gsub(/[^0-9A-Za-z]/, ' ')

          usrmsg_no_spchar_padded =" " +usermessage_no_spchar+" "
       
        # Perform SMS lingo handling 
          sms_lingos = SmsLingo.all
             matchresult =""
          sms_lingos.each do |lingo_record|
              # Pad SMS word with blankspaces so that we can match word inside text 
               sms_word = " "+lingo_record.sms_word+" "
              if  usrmsg_no_spchar_padded.include?sms_word
                 word_to_be_replaced = " "+ lingo_record.sms_word+" "
                 replaced_word = " " +lingo_record.english_text+" "
                 result= usermessage_modified.gsub!(word_to_be_replaced,replaced_word) 
                   if   result.nil?
                         match=/\W#{lingo_record.sms_word}\W/.match(usermessage_modified)
                         if !match.nil?
                            matchresult= match.to_s()
                            matchreplace= matchresult.gsub(lingo_record.sms_word,lingo_record.english_text)
                            usermessage_modified.gsub!(matchresult,matchreplace)

                         end  
                   end 
               end 
          end 	
          # End of SMS handling
          
          # Log Message after SMS Lingo Handling
           @datetime = Time.now.inspect
          @logger.info "#{@datetime} <#{@threadnumber}> Text after SMS Lingo correction : < #{usermessage_modified} >"
          
        
          # Perform Dictionary Corrections

          usermessage_no_spchar_smslingo= usermessage_modified.gsub(/[^0-9A-Za-z]/, ' ')   # Removing special characters so that dictionary correction can happen
               
          words = usermessage_no_spchar_smslingo.split(/\W+/)
           
          words.delete("") # Remove all null characters from array

          words.each do |word|
           # Traverser through all words with dictionary
           corrected_word = correct word
           # Check if response is the same as input 
	           if corrected_word != word
                        result= usermessage_modified.gsub!(word,corrected_word)
                        if   result.nil?
                         match=/\W#{word}\W/.match(usermessage_modified)
                            if !match.nil?
                                matchresult= match.to_s()
                                if !match.nil?
        	                    matchresult= match.to_s()
	                            matchreplace= matchresult.gsub(word,corrected_word)
                	            usermessage_modified.gsub!(matchresult,matchreplace)
	
        	                 end
                    	   end
                        end
                   end

           end 
           
         # Log Message after SMS Lingo Handling
          @datetime = Time.now.inspect
          @logger.info "#{@datetime} <#{@threadnumber}> Text after Dictionary Corrections : < #{usermessage_modified} >"
       
       # Handel Multiple Sentences by splitting into two sentences for Aiaioo handling
       
       # Check if sentence has but or although
       
       # Define message array to store split sentences for processing
       messagearray =[]
       keyword_but ="but"
       keyword_although="although" 
       if usermessage_modified.include?keyword_but or usermessage_modified.include?keyword_although
          
          if usermessage_modified.include?keyword_but
              split_keyword= 'but'
          else 
              split_keyword ='although'
          end   
          
          # Split the sentence into 2 and stor into array
          messagearray = usermessage_modified.split(split_keyword,2)
          @logger.info "#{@datetime} <#{@threadnumber}> Two sentence handling with <#{split_keyword}>"
          
       end    
       
       # Initialize message array in case we have no double sentence handling
          
          if messagearray.length == 0
             messagearray << usermessage_modified
          end
         messagecount=0
   messagearray.each do |message_to_be_analysed|         
       
        sentimentId = checkSentiments(message_to_be_analysed,@business_id)     
        messagecount += 1
         if sentimentId == -1
          # Store in Aiaioo retries table and forget
          @api_response=aiaiooErrorHandle()
           return
         end   
         
                
        # Log Sentiment Returned by AiAioo
        @datetime = Time.now.inspect
        @logger.info "#{@datetime} <#{@threadnumber}> AiAioo returned a sentiment of <#{sentimentId}>"

        # Sentiment Overrides Logic to be implemented

        sentiment_overrides_all = SentimentOverride.all

        sentiment_overrides_all.each do |sentiment_override|
          if usermessage_wo_prefix.include?sentiment_override.text
              sentimentId = sentiment_override.sentiment_id
              @logger.info "#{@datetime} <#{@threadnumber}> AiAioo sentiment Over-ridern by new sentiment <#{sentimentId}> "
              # Switch Case statment to set Sentiment Score
          end  
          
        end 
     
        case sentimentId
              when 1
                  sentimentScore =100
              when 3
                 sentimentScore =50
              else
                 sentimentScore=0
              end
        
        # Database Handling to store the results of incoming feedback post analysis by Aiaioo
        
        feedack_store =Feedback.create(:message=>usermessage_wo_prefix,:user_id=>usernumber.id,:sentiment_id=>sentimentId,:branch_id=>branches_record_match.id,:sentiment_score=>sentimentScore)
          
        
        
# Category Handling for CCD
if @business_record.unicel_vnumber=='9880263333'
# 
          #  Category Handling  so that the message Id is added to the correct category
          # Fetch all Keyword for category and check against incoming message.
                      
          
          
          category_keywords = CategoryKeyword.all
          
          # Iterate through all keywords to check if it exists in category clasification.
                    
          category_match_found = false
          
          category_keywords.each do |category_word|
          	   if  usermessage_modified.include?category_word.keyword
          	 	  # Category has matched, so indicate true for category_match
          	  	   category_match_found = true
          	    	 # update 
          	     	FeedbackCategory.create(:feedback_id=> feedack_store.id ,:category_id=>category_word.id ,:branch_id=>branches_record_match.id)
                  @datetime = Time.now.inspect
                  @logger.info "#{@datetime} <#{@threadnumber}> Incoming Message is mapped to category <#{category_word.id}>"
          	     	
          	  	end 
          end 	
          
          # if no category matched then match to default category of 'Others' for each business
          if !category_match_found 
          
               businessId = branches_record_match.business_id
               category_not_found=1 # Initialize Variable
               begin 
               category_record = Category.find_by_name_and_business_id!('Others',businessId)
               rescue ActiveRecord::RecordNotFound  
                @logger.info "#{@datetime} <#{@threadnumber}> 'Other' category not defined for this business"
                category_not_found = 0
               end
               
               if category_not_found != 0
               		categoryId = category_record.id
              	 	FeedbackCategory.create(:feedback_id=> feedack_store.id ,:category_id=>categoryId ,:branch_id=>branches_record_match.id)
               		@logger.info "#{@datetime} <#{@threadnumber}> Incoming Message is mapped to category default category 'Others'"
             end 
               
          end  
              
elsif  @business_record.unicel_vnumber=='9900536633'       # End of Category Handling for CCD
        checkIntent(usermessage_modified,@business_id)
        # Perform Intention Analysis to map to the right categories
  if @aiaioo_intent == -1
     @logger.info "#{@datetime} <#{@threadnumber}> AiAoo Down hence we could not perform intent analysis"
  end   

    keyword_please ='please'
    keyword_request ='kindly'
    if usermessage_modified.include?keyword_please or usermessage_modified.include?keyword_request
          @aiaioo_category = 'Request'
    else
         case @aiaioo_intent

          when 'opine'
                 if @aiaioo_intent_polarity = 'positive'
                    @aiaioo_category = 'Appreciation'
                 else
                    @aiaioo_category = 'Feedback'
                  end
          when 'complain'
              @aiaioo_category = 'Complaints'
          when  'inquire'
              @aiaioo_category = 'Query'
          when 'direct'
              @aiaioo_category = 'Others'
          when 'other'
              @aiaioo_category = 'Feedback'
           else
               @aiaioo_category = 'Others'
           end 

    end   
    # Fetch Category Id 
      category_record = Category.find_by_name_and_business_id!(@aiaioo_category,@business_id)
      categoryId = category_record.id
    FeedbackCategory.create(:feedback_id=> feedack_store.id ,:category_id=>categoryId ,:branch_id=>branches_record_match.id)

    @logger.info "#{@datetime} <#{@threadnumber}>  Incoming message mapped to <#{@aiaioo_category}> category after performing Aiaioo Intent analysis"


      
end  # End of Category handling for spencers

# Handle Message to user => After Category Handling !!
if messagearray.length == 1
        # Call Function to handle sending of Unicel messsage back to user
          handleUserMessage(sentimentId,branches_record_match.id, branches_record_match.business_id,@sendernumber,usernumber.id,feedack_store.id)
            
            if @business_record.unicel_vnumber=='9900536633'
                   if @aiaioo_category == "Appreciation" or @aiaioo_category =="Complaint"
                       @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert being sent as <#{@aiaioo_category}> is detected"
                       handleAlertstoStoreManager(feedack_store.id,branches_record_match.id,@sendernumber)
                    else 
                      @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert for Spencers skipped as SMS recieved is niether Appreciation or Complaint"
                    end  
           else  # Handle CCD Negative store alerts
               if sentimentId == 4
                      handleAlertstoStoreManager(feedack_store.id,branches_record_match.id,@sendernumber)
               else
                  @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert for CCD skipped as SMS recieved is not having negative sentiments"
               end   
           end 
        else 
            if messagecount == 1
               @sentimentid_1stsentence=sentimentId
           
            elsif messagecount == 2
               sentimentid_2ndsentence = sentimentId
               if @sentimentid_1stsentence == 4 or sentimentid_2ndsentence == 4
                  sentimentId =4
               elsif @sentimentid_1stsentence == 1 or sentimentid_2ndsentence == 1
                  sentimentId =1
               else 
                  sentimentId =3
               end
               
              handleUserMessage(sentimentId,branches_record_match.id, branches_record_match.business_id,@sendernumber,usernumber.id,feedack_store.id)
             if @business_record.unicel_vnumber=='9900536633'
                   if @aiaioo_category == "Appreciation" or @aiaioo_category =="Complaint"
                       @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert being sent as <#{@aiaioo_category}> is detected"
                       handleAlertstoStoreManager(feedack_store.id,branches_record_match.id,@sendernumber)
                    else 
                      @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert for Spencers skipped as SMS recieved is niether Appreciation or Complaint"
                    end  
           else  # Handle CCD Negative store alerts
               if sentimentId == 4
                      handleAlertstoStoreManager(feedack_store.id,branches_record_match.id,@sendernumber)
               else
                  @logger.info "#{@datetime} <#{@threadnumber}>  Store Alert for CCD skipped as SMS recieved is not having negative sentiments"
               end   
           end 
               


            end   
              
        end


        # Handling noun parsing using stanford dictionary 
        noun_array =[]
        text = usermessage_modified.gsub(/[^0-9A-Za-z]/, ' ')
        noun_array = extractNouns(text)
             
 	
     #  Store into Trending Topics tables
     noun_array.each do |noun|
        # store nouns in trending topics table 
         trendingtopic=TrendingTopic.create(:text=>noun ,:sentiment_id=>sentimentId, :branch_id=>branches_record_match.id,:sentiment_score=>sentimentScore)
         # Log nouns found 
         @datetime = Time.now.inspect
         @logger.info "#{@datetime} <#{@threadnumber}> Noun Found <#{noun}>"
         # Store Feedback_topics table so that we can access this is Dashboard
         FeedbackTopic.create(:feedback_id=>feedack_store.id,:trendingtopic_id=>trendingtopic.id,:branch_id=>branches_record_match.id)
                  
     end
 end # End of Message array handling for 2 sentence handling     
      



      
      # Special Handling for Spencers !!
         begin
              if @business_record.unicel_vnumber=='9900536633'
                 @logger.info "#{@datetime} <#{@threadnumber}>  Alert Generated to Santosh AR"
                 sendUnicelMessageSpencers(@usermessage,'9845376313')
                                 
                 # Email sent to Spencers Customer Care
                 # Map prefix key to store code
                 if keyword_not_found !=1
                      if prefix_keyword == "sarj"
                         storeCode = 'H032'
                      else
                         storeCode = "H018"
                      end
                 else 
                      storeCode = 'Not Indentified'
                 end 
  

                 # Generate Reference Number 
                    user_id = usernumber.id
                     # Query Feedbacks table to determine number of feedbacks which user has sent
                     feedback_count = Feedback.count(:all,:conditions=>["user_id=?",user_id]) 
                     # Increment count
                     feedback_count_integer = feedback_count.to_i()
                     #feedback_count_integer +=
                     syd_reference_number = @sendernumber +feedback_count_integer.to_s()

                 #                
                 @logger.info "#{@datetime} <#{@threadnumber}>  Sending this text by email <#{usermessage_wo_prefix}>"
 
                 Notifier.sms_recieved(@sendernumber,storeCode,usermessage_wo_prefix,@aiaioo_category,syd_reference_number).deliver
                 @logger.info "#{@datetime} <#{@threadnumber}>  Email with SMS sent out to Spencers Customer Care"
              end 
         end
         # Send SMS to Santosh

      
                      
   	end # End of if statement Unicel/handle
   
    respond_to do |format|
      format.html # index.html.erb
    end

  end

# Rails Method to extract the first n words in a string
def first_x_words(str,n=20,finish='&hellip;')
   str.split(' ')[0,n].inject{|sum,word| sum + ' ' + word} + finish
end




def extractNouns(sentence)
   # Function to Invoke Stanford Parser to extract nouns from incoming messages
    text = sentence
    noun_array=[]
		pipeline =  StanfordCoreNLP.load(:tokenize,:ssplit, :pos )
		 @datetime = Time.now.inspect
		 @logger.info "#{@datetime} <#{@threadnumber}> Loading Stanford Library for core NLP handling"
		text = StanfordCoreNLP::Annotation.new(text)
		pipeline.annotate(text)
	       # Use Stanford Core NLP Library to parse the incoming text into nouns 
		text.get(:sentences).each do |sentence|
	 	 sentence.get(:tokens).each do |token|
	    		# Default annotations for all tokens
	  		  word= token.get(:value).to_s
	                  pos_tag=token.get(:part_of_speech).to_s
	                  if pos_tag == 'NN'
	                    noun_array <<word
	                  end
	
		   end # End of word loop
     end # end of loop for sentences
    
		  return noun_array
end


def handleUserMessage(sentimentid,branchid,businessid,destinationnumber,userid,feedbackid)

    if sentimentid ==1  
       # Call Google API to shortner with URL for FBShare
       fbshareBaseUrl =Configtable.find_by_name_and_business_id('fb_redirect_url',@business_id).value
       fbshareURL = fbshareBaseUrl + feedbackid.to_s() 
       Google::UrlShortener::Base.api_key = "AIzaSyCMgapfDaI9tXZJG9TmWvw6kha8lBIUeqU"
       url = Google::UrlShortener::Url.new(:long_url => fbshareURL)
       fbshareURLShort = url.shorten! 
       @logger.info "#{@datetime} <#{@threadnumber}> Google URL Shortner Invoked for <#{fbshareURL}> and shortened URL returned <#{fbshareURLShort}> "
    end
   
       # Fetch the message to be delivered to end customer based on sentiment ,branch and business id
       
      	 	begin  # Begin block to fetch custom messages
                    custom_message = CustomMessage.find_by_branch_id_and_business_id_and_sentiment_id!(branchid,businessid,sentimentid)
                    rescue ActiveRecord::RecordNotFound
                     # place holder to handle error
        	 end  

            
            # Build message to send it ouside using Unicel API 
                message_unicel = custom_message.message
           #  Replace coupon code if configured for business id
           if @business_record.mcoupon 
             coupon_code = fetchMcoupons()        
             message_unicel.gsub!("@",coupon_code)
           else
             @logger.info "#{@datetime} <#{@threadnumber}> Skipping mcoupon handling as it is not configured as business"
           end   
            
              # Replace {fburl} in case the message is positive sentiment
              if sentimentid ==1
                message_unicel.gsub!("{fburl}",fbshareURLShort)
              end

          
         # Log Unicel message which needs to be sent
        @datetime = Time.now.inspect
        @logger.info "#{@datetime} <#{@threadnumber}> Unicel Message to be sent to phone number <#{@sendernumber}> is <#{message_unicel}>"
            
                             
          unicel_response_string= sendUnicelMessage(message_unicel,destinationnumber)
          @api_response= message_unicel 
          #  OutGoing Logs to be updated 
          OutgoingMessageLog.create(:message=>message_unicel ,:destination_mobile_number=>@sendernumber,:message_status=>unicel_response_string,:user_id=>userid)
          
end 




def handleAlertstoStoreManager(feedbacknumber, branchid,sendernumber)
		
		
		         # Perform Check if Alerts need to be handled
		         # Fetch Business Id to 
		           branch_record = Branch.find(branchid)
		         # Get Business Id
		           businessId =  branch_record.business_id
		         # Fetch Business Record to check if we need to perform SMS Alerts
		           business_record = Business.find(businessId)
		           
		           if !business_record.sms_alerts 
		             # No need to perform sms alerts
		             @logger.info "#{@datetime} <#{@threadnumber}> Alert Generation Aborted because it is not configured for this business id " 
		             return
		           end 
		        
		
		            alerts_template = Configtable.find_by_name_and_business_id('alert_notification',@business_id).value 
                alerts_fburl_template = Configtable.find_by_name_and_business_id('fb_alert_url',@business_id).value
                feedbackid_string =  feedbacknumber.to_s()
                alerts_fburl =  alerts_fburl_template.gsub("{0}",feedbackid_string) 
                Google::UrlShortener::Base.api_key = "AIzaSyCMgapfDaI9tXZJG9TmWvw6kha8lBIUeqU"
      				  url = Google::UrlShortener::Url.new(:long_url => alerts_fburl)
       				  alertsURLShort = url.shorten! 
               
                # Replace %fburl% with Google Shortened URL
                alerts_template.gsub!("%fburl%",alertsURLShort)
                
                # Replace {0} with phone number inside alerts Message
                alerts_template.gsub!("{0}",sendernumber)
               
                               
                 branch_details = Branch.find(branchid)
                
                alerts_destination ="&dest="+ branch_details.contact_number
                
                # Spencers Specific Handling
           if @business_record.unicel_vnumber=='9900536633' 
               feedback_record = Feedback.find(feedbacknumber)
               alerts_templates = "You have recieved a message from {0}. The text is : {text}" 
               alerts_templates.gsub!("{0}",sendernumber)
               alerts_templates.gsub!("{text}",feedback_record.message)
               @logger.info "#{@datetime} <#{@threadnumber}> Alert! to be generated and sent to <#{branch_details.contact_number}> " 
               @logger.info "#{@datetime} <#{@threadnumber}> Alert text <#{alerts_templates}>"
               alerts_unicel_response=sendUnicelMessageSpencers(alerts_templates,alerts_destination)   

          else 
                 # Default handling for CCD , call message template to view the message by clicking URL
                 @logger.info "#{@datetime} <#{@threadnumber}> Alert! to be generated and sent to <#{branch_details.contact_number}> " 
                 @logger.info "#{@datetime} <#{@threadnumber}> Alert text <#{alerts_template}>"
                 alerts_unicel_response=sendUnicelMessage(alerts_template,alerts_destination)
          end 
		
end 




def sendUnicelMessage(message, destination)
# Send Unicel Message after constructing URL
# Fetch Unicel Base URL, Username password and unicel_number
          unicel_baseurl =  Configtable.find_by_name_and_business_id('unicel_url',@business_id).value
          unicel_username = "&uname="+ Configtable.find_by_name_and_business_id('unicel_uname',@business_id).value
          unicel_password = "&pass="+Configtable.find_by_name_and_business_id('unicel_password',@business_id).value
          unicel_number = "&send="+Configtable.find_by_name_and_business_id('unicel_number',@business_id).value
 # Url encode the message string so that we can pass this to Unicel
      url_encoded_message = "&msg="+URI.escape(message) 
      destinationnumber = "&dest=" + destination
      
      # Build Unicel URL
          unicel_url = unicel_baseurl+ "?"+ unicel_username + unicel_password +url_encoded_message +destinationnumber+ unicel_number 
          @logger.info "#{@datetime} <#{@threadnumber}> Unicel API invoked to send out message <#{unicel_url}> "  
          unicel_response = RestClient.get unicel_url
          unicel_response_string=unicel_response.to_str
          @logger.info "#{@datetime} <#{@threadnumber}> Response from Unicel API <#{unicel_response_string}> "
    
end 

# Special Handling for alerts to be send to subscribers .To be invoked from Handle alerts in case vnumber = spencers
def sendUnicelMessageSpencers(message, destination)
# Send Unicel Message after constructing URL
# Fetch Unicel Base URL, Username password and unicel_number
          unicel_baseurl =  Configtable.find_by_name_and_business_id('unicel_url',@business_id).value
          unicel_username = "&uname="+ "Spencr"
          unicel_password = "&pass="+ "A5m1Y5h$"
          unicel_number = "&send="+Configtable.find_by_name_and_business_id('unicel_number',@business_id).value
 # Url encode the message string so that we can pass this to Unicel
      url_encoded_message = "&msg="+URI.escape(message) 
      destinationnumber = "&dest=" + destination
      
      # Build Unicel URL
          unicel_url = unicel_baseurl+ "?"+ unicel_username + unicel_password +url_encoded_message +destinationnumber+ unicel_number 
          @logger.info "#{@datetime} <#{@threadnumber}> Unicel API invoked with Opt-in password to send out message <#{unicel_url}> "  
          unicel_response = RestClient.get unicel_url
          unicel_response_string=unicel_response.to_str
          @logger.info "#{@datetime} <#{@threadnumber}> Response from Unicel API <#{unicel_response_string}> "
    
end 



def fetchMcoupons

    # Fetch mcoupon code to be delivered as SMS. Fetch first match with status =1
             begin # Begin block for mcoupon fetching
                coupon_code_empty=FALSE
              	coupon = Mcoupon.find_by_status_and_business_id!(0,@business_id)
             	 rescue ActiveRecord::RecordNotFound
               		 coupon_code_empty=TRUE
             end
           
             if coupon_code_empty
               coupon_code = '@'
               @logger.info "#{@datetime} <#{@threadnumber}> !!!!Coupon Code used up , using @ to respond to user!!! " 
              else
                coupon_code= coupon.coupon_code
                coupon.status =1
                coupon.save
                @logger.info "#{@datetime} <#{@threadnumber}> Coupon Code of <#{coupon_code}> fetched and used " 
             end
        
            
       return coupon_code    
    
end



def aiaiooErrorHandle
    # Handle the situation when Aiaioo is down by sending an error message and updating AiAiooFailure tables
    
    # Store incoming message and text 
    AiaiooFailure.create(:source_number=>@sendernumber, :text=>@usermessage,:retried=> 0)
    
    # Send the message to end customer that his message has been recieved.
    aiaioo_failure_template = Configtable.find_by_name_and_business_id('aiaioo_failure',@business_id).value 
    coupon_code = fetchMcoupons()
    
    # Replace couponcode insite the message
    aiaioo_failure_message = aiaioo_failure_template.gsub("@",coupon_code)
    
    sendUnicelMessage(aiaioo_failure_message,@sendernumber)
        
    return   aiaioo_failure_message
        
end 


def checkSentiments (sentence,businessid)
# Return sentimentId if sucessfull else return -1 (Aiaioo failure)
        
         aiaioo_base_url = Configtable.find_by_name_and_business_id('aiaioobaseurl',businessid).value
          
         # URL Encode the message before calling Aiaiaoo API
         percentage_string ='%'
         if sentence.include?percentage_string
             sentence.gsub!("%","%25")
         end
         # Special handling for Aiaioo as it fails for % char encoding so we need double encoding i.e % to be mapped to %2525.
         
         uri_escape_message = URI.escape(sentence)
         
         aiaioo_url = aiaioo_base_url +uri_escape_message        
         
         # Aiaioo Check if API is not responding
         
         begin
         aiaiooresponse= RestClient.get(aiaioo_url){|response, request, result| response }
         rescue 
         # Rescue in case Restclient is not getting any connection to Aiaioo server due to internet connectivity
            @api_response = aiaiooErrorHandle()
            @datetime = Time.now.inspect
            @logger.info "#{@datetime} <#{@threadnumber}> AiAioo API is down due to internet connectivity"
           return
         end 	
        # Check if Aiaioo responds with the right code for response else invoke Aiaioo handling
				if aiaiooresponse.code != 200
				    sentimentId= -1
				    @datetime = Time.now.inspect
           	@logger.info "#{@datetime} <#{@threadnumber}> AiAioo API Error due to formating of XML response"
				    return sentimentId
			  end 
          
         aiaiooxmlresponse=aiaiooresponse.to_str

             aiaiooresults_hash= Crack::XML.parse(aiaiooxmlresponse)
             
             #sentiment =aiaiooresults_hash["api"]["result"]["documents"]["document"]["sentiment"]
             sentiment = aiaiooresults_hash["api"].andand["result"].andand["documents"].andand["document"].andand["sentiment"]
             # Aiaioo Results Hash parsing 
            
             
        # Switch Case statement to assign sentiments
				        case sentiment
				        when "negative" 
				           sentimentId = 4
				        when "positive"
				           sentimentId = 1
				        when "neutral"
				           sentimentId = 3
				       else
				            sentimentId= -1
				            @datetime = Time.now.inspect
           					@logger.info "#{@datetime} <#{@threadnumber}> AiAioo API Error due to formating of XML response"
				            return sentimentId
				        end        
return sentimentId

end 


def checkIntent (sentence,businessid)
# Return intent if sucessfull else return -1 (Aiaioo failure)
        
         aiaioo_base_url = Configtable.find_by_name_and_business_id('aiaioobaseurl',businessid).value
          
         # Replace vaksent with vakintent in the base URL
         
         aiaioo_base_url.gsub!("vaksent","vakintent")


         # URL Encode the message before calling Aiaiaoo API
         percentage_string ='%'
         if sentence.include?percentage_string
             sentence.gsub!("%","%25")
         end
         # Special handling for Aiaioo as it fails for % char encoding so we need double encoding i.e % to be mapped to %2525.
         
         uri_escape_message = URI.escape(sentence)
         
         aiaioo_url = aiaioo_base_url +uri_escape_message        
         
         # Aiaioo Check if API is not responding
         
         begin
         aiaiooresponse= RestClient.get(aiaioo_url){|response, request, result| response }
         rescue 
         # Rescue in case Restclient is not getting any connection to Aiaioo server due to internet connectivity
            @api_response = aiaiooErrorHandle()
            @datetime = Time.now.inspect
            @logger.info "#{@datetime} <#{@threadnumber}> AiAioo API is down due to internet connectivity"
           return
         end  
        
          
         aiaiooxmlresponse=aiaiooresponse.to_str

             aiaiooresults_hash= Crack::XML.parse(aiaiooxmlresponse)
             
             
             @aiaioo_intent = aiaiooresults_hash["api"].andand["result"].andand["documents"].andand["document"].andand["intention"]
             # Aiaioo Results Hash parsing 
              @logger.info "#{@datetime} <#{@threadnumber}> AiAioo API #{@aiaioo_intent} as the intent" 
             @aiaioo_intent_polarity = aiaiooresults_hash["api"].andand["result"].andand["documents"].andand["document"].andand["polarity"]
              @logger.info "#{@datetime} <#{@threadnumber}> AiAioo API #{@aiaioo_intent_polarity} as the polarity"

             
        
return @aiaioo_intent

end 





# Read the parameter requests and map to internal variables
  	def initializeRequestData
   	# Read incoming message from user
  	 #http://www.shoppersays.com:9000/unicel?msg=<MESSAGE TXT>&sender=<MOBILE NUMBER>&vnumber=9880263333
     	if params[:msg].present?
      		message=params[:msg]
                @usermessage=message.downcase # Convert it into lower case for processing
                
    	else
      		return 0
   	 end
   	 
   	 if params[:vnumber].present?
    		@virtualnumber =params[:vnumber]
   	 else
    		return 0
     end
   	 
    
    	if params[:sender].present?
    		@sendernumber =params[:sender]
   	 else
    		return 0
    	end

    end 
end

class Aiaioorerun
   
   
   def runAiaioo
  
    @logger = Logger.new('SMSFeedbaclApp.log')
    @datetime = Time.now.inspect
    @logger.info "#{@datetime}   AiAioo Retries Logic Started"
  	 		begin
   					aiaioofailures =AiaiooFailure.find(:all, :conditions=>["retried=?",0])
   			rescue ActiveRecord::RecordNotFound
   			     @logger.info "#{@datetime}   AiAioo Retries Found nothing to be done"   
     	  end 
     	aiaioofailures.each do |aiaioofailure|
     		   
     		   
     		    
     	end 
     	  
   end
   

end
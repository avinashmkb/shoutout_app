# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Feedback.create(:message => 'CCD mera favorite hangout hai',
  :user_id => 3,
  :sentiment_id => 2,    
  :branch_id => 5,
   :sentiment_score => 100
  )
Feedback.create(:message => 'Tropical Treat was good , but AC was not warm',
  :user_id => 1,
  :sentiment_id => 1,    
  :branch_id => 5,
  :sentiment_score => 75
  )  

Feedback.create(:message => 'Coffee was good , but the sandwich sheer heaven',
  :user_id => 1,
  :sentiment_id => 2,    
  :branch_id => 5,
  :sentiment_score => 100
  )  
  
  Feedback.create(:message => 'Cade Mocha with Hazelnut sauce was very good',
  :user_id => 2,
  :sentiment_id => 2,    
  :branch_id => 5,
  :sentiment_score => 100
  )  
 
 
  
 
  
    
  
  
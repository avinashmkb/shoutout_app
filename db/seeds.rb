# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Feedback.create(:message => 'CCD staff was helpful in getting me what i wanted from the menu',
 :user_id => 3,
:sentiment_id => 1,    
:branch_id => 5,
 :sentiment_score => 75
 )

Feedback.create(:message => 'Hmm the guy cleaning the floor was not clean i mean he was drunk',
 :user_id => 3,
:sentiment_id => 2,    
:branch_id => 5,
 :sentiment_score => 100
 )

Feedback.create(:message => 'The staff is not friendly, but product is good',
 :user_id => 3,
:sentiment_id => -1,    
:branch_id => 5,
 :sentiment_score => 25
 )
 
Feedback.create(:message => 'Did not like the way the staff treated me , he should show respect',
 :user_id => 3,
:sentiment_id => -1,    
:branch_id => 5,
 :sentiment_score => 75
 ) 
   


 
  
    
  
  
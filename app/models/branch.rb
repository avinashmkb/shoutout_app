class Branch < ActiveRecord::Base
  belongs_to :business
  has_one :keyword
  has_many :offers
end

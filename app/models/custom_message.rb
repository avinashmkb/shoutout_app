class CustomMessage < ActiveRecord::Base
  belongs_to :business
  belongs_to :branch
  belongs_to :sentiment
end

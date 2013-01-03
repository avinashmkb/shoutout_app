class TrendingTopic < ActiveRecord::Base
  belongs_to :sentiment
  belongs_to :branch
end

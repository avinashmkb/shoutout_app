class Keyword < ActiveRecord::Base
  belongs_to :business
  belongs_to :branch
end


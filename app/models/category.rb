class Category < ActiveRecord::Base
  belongs_to :business
  has_many :category_keywords, :dependent => :destroy
end

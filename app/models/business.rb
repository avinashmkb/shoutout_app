require 'digest/sha2'

class Business < ActiveRecord::Base
	has_many :branches, :dependent => :destroy
	has_many :categories, :dependent => :destroy
	has_many :keywords, :dependent => :destroy

	validates :name, :presence => true
	validates :login_id, :presence => true, :uniqueness => true
	validates :password, :confirmation => true
	attr_accessor :password_confirmation
	attr_reader :password

	validate :password_must_be_present

	def Business.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "random" + salt)
	end

	def password=(password)
		@password = password
		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	private

	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end

	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

	def Business.authenticate(login_id, password)
		if business = find_by_login_id(login_id)
			if business.hashed_password == encrypt_password(password, business.salt)
				business
			end
		end
	end
end

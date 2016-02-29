class User < ActiveRecord::Base
  has_many :posts
  before_create :remember
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true
  
  def User.new_token
		Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s)
	end

  private
		def remember
			self.remember_token = User.new_token
		end
end

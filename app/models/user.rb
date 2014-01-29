include Calculations
class User < ActiveRecord::Base
	has_many :user_times
	validates_format_of :username,  :with => /\A[a-zA-Z0-9]+[^\W]\z/
   validates :username,   :presence => true, :uniqueness => true 
end

class Photo < ActiveRecord::Base
	has_one :folder
	has_one :user, through: :folder
end

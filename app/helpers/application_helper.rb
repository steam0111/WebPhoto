module ApplicationHelper
	def require_login
		if !user_signed_in?
		  flash[:error] = "You must be logged in to access this section"
		  redirect_to root_path # прерывает цикл запроса
		end
	end
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end
end

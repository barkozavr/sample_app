class ApplicationController < ActionController::Base
	def hello
		render html: "COVID УХОДИ!"
	end
end

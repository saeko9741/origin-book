class SearchesController < ApplicationController
  def show
  	@user_name = current_user.name
  end
end

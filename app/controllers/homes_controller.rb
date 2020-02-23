class HomesController < ApplicationController
  def top
  end

  def about
  	@user_name = current_user.name
  end
end

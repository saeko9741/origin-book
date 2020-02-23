class HomesController < ApplicationController
  def top
  	@user_name = current_user.name
  end

  def about
  end
end

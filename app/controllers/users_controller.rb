class UsersController < ApplicationController
  def dashboard
    @rewards = current_user.rewards
  end
end

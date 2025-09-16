class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @lectures = current_user.lectures
  end
end
class SchedulesController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Schedule.all
  end
end

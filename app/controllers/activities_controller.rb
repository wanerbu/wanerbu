class ActivitiesController < ApplicationController
  def activity_home
  end
  def new
    @activity = Activity.new
  end
end

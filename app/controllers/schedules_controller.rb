class SchedulesController < ApplicationController
  def new
    @sections  = Section.all
    @schedule = current_user.schedules.new
  end

  def create
    @schedule = current_user.schedules.create(permitted_params)
  end

  def show
    @schedule = current_user.schedules.find_by_id(params[:id])
  end

  private

  def permitted_params
    params.require(:schedule).permit(:section_id)
  end
end

class EventsController < ApplicationController
  before_action :require_admin_access, except: [:show]
  before_action :set_event, except: [:new, :create]

  def show
    @members = Member.order(:id)
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to @event, flash: {
        success: 'flash.create.success'.t
      }
    else
      render :new
    end
  end

  def update
    if @event.update event_params
      redirect_to @event, flash: {
        success: 'flash.update.success'.t
      }
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find params[:id]
  end

  def event_params
    params.require(:event).permit(
      :title,
      :location,
      :date,
      :cost_from_members_budget,
      :cost_from_team_budget
    )
  end
end

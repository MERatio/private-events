class EventsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @events = Event.paginate(page: params[:page])
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = 'Event created'
      redirect_to events_path
    else
      render :new
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    @attendees = @event.attendees.paginate(page: params[:page])
  end    

  def past_events
    @past_events = Event.past.paginate(page: params[:page])
  end

  def upcoming_events
    @upcoming_events = Event.upcoming.paginate(page: params[:page])
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :location, 
                                    :start_date, :end_date)
    end
end

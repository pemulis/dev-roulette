class EventsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:tag]
      @events = Event.tagged_with(params[:tag]).order("date DESC")
    else
      @events = Event.all.order("date DESC")
    end
  end

  def show
    @event = Event.find(params[:id])
    @commentable = @subscribable = @event
    @comments = @commentable.comments
    @comment = Comment.new
    @subscriptions = @subscribable.subscriptions
    @subscription = Subscription.new
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
    if @event.save
      redirect_to @event, notice: 'Your event post was successful!'
    else
      notice = 'Something went wrong when we tried to add your event...'
      render action: 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update_attributes!(event_params)
      redirect_to @event, notice: 'Your event details were updated!'
    else
      redirect_to @event, notice: 'Something went wrong when we tried to update your event...'
    end
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :image_url, :location, :date, :tag_list)
  end

end

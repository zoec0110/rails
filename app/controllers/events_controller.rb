class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  def index
    @events = Event.all
    # @events = Event.page(params[:page]).per(5)
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml { render xml: @events.to_xml }
    #   format.json { render json: @events.to_json }
    #   format.atom { @feed_title = 'My event list' } # index.atom.builder
    sort_by = params[:order] == 'name' ? 'name' : 'created_at'
    @events = Event.order(sort_by).page(params[:page]).per(5)
  end

  def new
    @event = Event.new
  end

  def show
    @page_title = @event.name
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render json: { id: @event.id, name: @event.name }.to_json }
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      flash[:notice] = 'event was successfully updated'
      redirect_to event_url(@event)
    else
      render action: :edit
    end
  end

  def destroy
    @event.destroy
    flash[:alert] = 'event was successfully deleted'
    redirect_to events_url
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'event was successfully created'
      redirect_to events_url
    else
      render action: :new
    end
  end

  def latest
    @events = Event.order("id DESC").limit(3)
  end

  def bulk_delete
    Event.destroy_all
    redirect_to events_path
  end

  def dashboard
    @event = Event.find(params[:id])
  end

  private

    def event_params
      params.require(:event).permit(:name, :description, :category_id,
        location_attributes: [:id, :name, :_destroy], group_ids: [])
    end

    def set_event
      @event = Event.find(params[:id])
    end
end

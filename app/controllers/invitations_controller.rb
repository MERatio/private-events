class InvitationsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @invitation = Invitation.new(event_id: params[:id])
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      attendee = User.find_by(id: invitation_params[:attendee_id])
      flash[:success] = "Successfully invited #{attendee.name}"
      redirect_to event_path(invitation_params[:event_id])
    else
      render :new
    end
  end

  private

    def invitation_params
      params.require(:invitation).permit(:attendee_id, :event_id)
    end
end

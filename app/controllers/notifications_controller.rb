class NotificationsController < ApplicationController
    
    def destroy
        @notification = Notification.find(params[:id])
        @notification.destroy
        redirect_to traid_path(@notification.traid_id)
    end
end
# app/controllers/api/v1/messages_controller.rb

module Api
  module V1
    class TrackMessagesController < ApplicationController
      before_action :set_conversation
      before_action :set_message, only: [:show, :update, :destroy]

      # GET /api/v1/conversations/:conversation_id/messages
      def index
        @messages = @conversation.track_messages
        render json: @messages
      end

      # GET /api/v1/conversations/:conversation_id/messages/:id
      def show
        render json: @message
      end

      # POST /api/v1/conversations/:conversation_id/messages
      def create
        @message = @conversation.track_messages.new(message_params)
				@message.user = current_user
        if @message.save
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/conversations/:conversation_id/messages/:id
      def update
        if @message.update(message_params)
          render json: @message
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/conversations/:conversation_id/messages/:id
      def destroy
        @message.destroy
        head :no_content
      end

      private

      def set_conversation
        @conversation = TrackConversation.find(params[:track_conversation_id])
      end

      def set_message
        @message = @conversation.track_messages.find(params[:id])
      end

      def message_params
        params.require(:track_message).permit(:content, :deleted)
      end
    end
  end
end

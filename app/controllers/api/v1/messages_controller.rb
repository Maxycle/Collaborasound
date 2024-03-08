# app/controllers/api/v1/messages_controller.rb

module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_conversation
      before_action :set_message, only: [:show, :update, :destroy]

      # GET /api/v1/conversations/:conversation_id/messages
      def index
        @messages = @conversation.messages
        render json: @messages
      end

      # GET /api/v1/conversations/:conversation_id/messages/:id
      def show
        render json: @message
      end

      # POST /api/v1/conversations/:conversation_id/messages
      def create
        @message = @conversation.messages.new(message_params)
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
        @conversation = Conversation.find(params[:conversation_id])
      end

      def set_message
        @message = @conversation.messages.find(params[:id])
      end

      def message_params
        params.require(:message).permit(:content)
      end
    end
  end
end

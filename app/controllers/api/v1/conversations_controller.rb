# app/controllers/api/v1/conversations_controller.rb

module Api
  module V1
    class ConversationsController < ApplicationController
      before_action :set_conversation, only: [:show, :update, :destroy]

      # GET /api/v1/conversations
      def index
        @conversations = Conversation.all
        render json: @conversations
      end

      # GET /api/v1/conversations/:id
			def show
				@messages = @conversation.messages.order(created_at: :asc).map do |message|
					{
						id: message.id,
						content: message.content,
						isDeleted: message.deleted,
						user_first_name: message.user.first_name,
						user_id: message.user.id,
						created_at: message.created_at,
						updated_at: message.updated_at
					}
				end
				
				render json: {
					music_track_parent: @conversation.music_track_id,
					messages: @messages
				}
			end
			

      # POST /api/v1/conversations
      def create
        @conversation = Conversation.new(conversation_params)
        if @conversation.save
          render json: @conversation, status: :created
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/conversations/:id
      def update
        if @conversation.update(conversation_params)
          render json: @conversation
        else
          render json: @conversation.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/conversations/:id
      def destroy
        @conversation.destroy
        head :no_content
      end

			def by_track
        conversation = Conversation.find_by(music_track_id: params[:trackId])
        if conversation
          render json: conversation
        else
          render json: { error: 'Conversation not found' }, status: :not_found
        end
      end

      private

      def set_conversation
        @conversation = Conversation.find(params[:id])
      end

      def conversation_params
        params.require(:conversation).permit(:music_track_id)
      end
    end
  end
end

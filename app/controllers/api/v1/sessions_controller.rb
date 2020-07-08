# frozen_string_literal: true

module Api
  module V1
    # Controls the User authentication actions.
    class SessionsController < ApplicationController
      before_action :set_user, only: %i[create destroy]

      def create
        if @user&.valid_password? session_params[:password]
          render json: @user, status: :created
        else
          head :unauthorized
        end
      end

      def destroy
        if @user
          @user.authentication_token = nil
          @user.save ? (head :no_content) : (head :internal_server_error)
        else
          render json: { error: 'Authentication required' },
                 status: :unauthorized
        end
      end

      private

      def set_user
        if params[:action] == 'create'
          @user = User.find_by email: session_params[:email]
        elsif params[:action] == 'destroy'
          @user = user_from_authentication_token
        end
      end

      def session_params
        @session_params ||= params.require(:user).permit(:email, :password)
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    # Controls the User authentication actions.
    class SessionsController < ApplicationController
      before_action :set_user, only: %i[create destroy]

      def create
        if @user&.valid_password? login_params[:password]
          render json: @user.as_json(only: %i[id email authentication_token]),
                 status: :created
        else
          head :unauthorized
        end
      end

      def destroy
        @user&.authentication_token = nil
        if @user.save
          head :no_content
        else
          head :error
        end
      end

      private

      def set_user
        if params[:action] == 'create'
          @user = User.find_by email: login_params[:email]
        elsif params[:action] == 'destroy'
          @user = User.find_by authentication_token: logout_params[:authentication_token]
        end
      end

      def login_params
        @login_params ||= params.require(:user).permit(:email, :password)
      end

      def logout_params
        @logout_params ||= {
          email: request.headers['X-User-Email'],
          authentication_token: request.headers['X-User-Token']
        }
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    # Controls the User authentication actions.
    class SessionsController < ApplicationController
      def create
        if user_in&.valid_password? create_params[:password]
          render json: user_in.as_json(only: %i[id email authentication_token]),
                 status: :created
        else
          head :unauthorized
        end
      end

      def destroy
        user_out.authentication_token = nil
        if user_out.save
          head :no_content
        else
          head :error
        end
      end

      private

      def user_in
        @user_in = User.find_by email: create_params[:email]
      end

      def user_out
        @user_out = User.find_by authentication_token: destroy_params[:authentication_token]
      end

      def create_params
        params.require(:user).permit(:email, :password)
      end

      def destroy_params
        params.permit(:authentication_token)
      end
    end
  end
end

# frozen_string_literal: true

module Api
  module V1
    # Get some data about people associated to their corresponding users.
    class PeopleController < ApplicationController
      def whoami
        user = user_from_authentication_token
        if user
          render json: user.person, status: :ok
        else
          head :unauthorized
        end
      end
    end
  end
end

# frozen_string_literal: true

# Helps to get request headers related to authentication token.
module SessionHelper
  extend ActiveSupport::Concern

  included do
    private

    def authentication_headers
      @authentication_headers ||= {
        email: request.headers['X-User-Email'],
        authentication_token: request.headers['X-User-Token']
      }
    end

    def user_from_authentication_token
      User.find_by(
        authentication_token: authentication_headers[:authentication_token]
      )
    end
  end
end

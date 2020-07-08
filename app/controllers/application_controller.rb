# frozen_string_literal: true

# The parent controller for all other controllers in the application.
class ApplicationController < ActionController::API
  include SessionHelper

  acts_as_token_authentication_handler_for User, fallback: none
end

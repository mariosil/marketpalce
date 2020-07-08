# frozen_string_literal: true

# Overrides the sign_in, sign_out methods from devise
module SessionHelpers
  extend ActiveSupport::Concern

  included do
    private

    def sign_in(user)
      user.authentication_token = nil
      user.save
    end

    def sign_out(user)
      user.authentication_token = 'logged_out_by_helper'
      user.save
    end
  end
end

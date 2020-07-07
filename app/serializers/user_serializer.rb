# frozen_string_literal: true

# Helps to avoid specify which User attributes will be included in response.
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token
end

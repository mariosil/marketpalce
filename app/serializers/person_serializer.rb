# frozen_string_literal: true

# Helps to avoid specify which Person attributes will be included in response.
class PersonSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :age
end

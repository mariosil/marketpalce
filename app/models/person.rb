# frozen_string_literal: true

# Models people table.
class Person < ApplicationRecord
  belongs_to :user

  validates_presence_of :firstname, :lastname, :age, :user
  validates :age, numericality: { greater_than: 18 }
end

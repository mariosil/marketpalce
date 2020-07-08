# frozen_string_literal: true

# Creates 'people' table.
class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.integer :age
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

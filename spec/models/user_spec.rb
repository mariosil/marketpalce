# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with all required fields' do
    let(:user) { User.new(email: 'user@email.com', password: '123123') }
    it 'shuld save without errors' do
      expect(user.valid?).to be true
      expect(user.errors.to_a).to be_empty
    end
  end
  context 'with no required fields' do
    let(:user) { User.new }
    it 'shuld not allow to save' do
      expect(user.valid?).to be false
      expect(user.errors.to_a).to_not be_empty
      expect(user.errors[:email]).to include "can't be blank"
      expect(user.errors[:password]).to include "can't be blank"
      expect(user.save).to be false
    end
  end
end

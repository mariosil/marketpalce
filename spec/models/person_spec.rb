# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  fixtures :people
  fixtures :users

  let(:person) { people :medium_age_person }

  context 'with all required fields' do
    it 'should allow to save' do
      expect(person.valid?).to be true
    end
    context 'with not all required fields' do
      it 'should not allow to save if firstname is blank ' do
        person.firstname = nil
        expect(person.valid?).to be false
        expect(person.errors[:firstname]).to include("can't be blank")
      end
      it 'should not allow to save if lastname is blank ' do
        person.lastname = nil
        expect(person.valid?).to be false
        expect(person.errors[:lastname]).to include("can't be blank")
      end
    end
  end
  context 'with under permit age field' do
    let(:underage_person) { people :under_age_person }
    it 'should not allow to save' do
      expect(underage_person.valid?).to be false
      expect(underage_person.errors[:age]).to include('must be greater than 18')
    end
  end
  context 'with no associated user' do
    it 'should not allow to save' do
      person.user = nil
      expect(person.valid?).to be false
      expect(person.errors[:user]).to include('must exist', "can't be blank")
    end
  end
end

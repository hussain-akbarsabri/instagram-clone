# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when validation test fails' do
    it 'ensures username presence' do
      user = described_class.create(email: Faker::Internet.email, password: '123123', password_confirmation: '123123')
      expect(user).to eq(false)
    end
  end
end

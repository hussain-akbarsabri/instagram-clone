# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to belong_to(:user) }
  end
end

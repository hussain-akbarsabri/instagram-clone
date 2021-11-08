# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/allow_content_type'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to allow_content_types('image/png', 'image/jpeg', 'image/jpg').for(:image) }
  end
end

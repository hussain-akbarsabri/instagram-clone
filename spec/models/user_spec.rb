# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/allow_content_type'

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe 'associations' do
    it { is_expected.to have_one_attached(:image) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:stories).dependent(:destroy) }
    it { is_expected.to have_many(:followers).dependent(:restrict_with_exception).inverse_of(false) }
    it { is_expected.to have_many(:followings).dependent(:restrict_with_exception).inverse_of(false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(15) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:name).is_at_most(30) }
    it { is_expected.to validate_length_of(:bio).is_at_most(50) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to allow_content_types('image/png', 'image/jpeg', 'image/jpg').for(:image) }
  end
end

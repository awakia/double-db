require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, name: 'Naoyoshi Aikawa', location: 'Tokyo', companies: ['Wantedly', 'Google']) }
  describe "associations" do
    it "works" do
      expect(user.profile).to be_present
      expect(user.profile.location).to eq 'Tokyo'
      expect(user.profile.working_histories.size).to eq 2
    end
  end
end

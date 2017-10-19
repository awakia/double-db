require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, name: 'Naoyoshi Aikawa', location: 'Tokyo', companies: ['Wantedly', 'Google']) }
  describe "associations" do
    it "works" do
      expect(user.profile).to be_present
      expect(user.profile.location).to eq 'Tokyo'
      expect(user.profile.working_histories.size).to eq 2

      u = User.includes(profile: :working_histories).to_a.last
      expect(u.profile).to be_present
      expect(u.profile.location).to eq 'Tokyo'
      expect(u.profile.working_histories.size).to eq 2

      u2 = User.preload(profile: :working_histories).to_a.last
      expect(u2.profile).to be_present
      expect(u2.profile.location).to eq 'Tokyo'
      expect(u2.profile.working_histories.size).to eq 2

      expect { User.eager_load(profile: :working_histories).to_a }.to raise_error(ActiveRecord::StatementInvalid)
      expect { User.includes(:profile).where(profile: { location: 'Tokyo' }).to_a }.to raise_error(ActiveRecord::StatementInvalid)
    end
  end
end

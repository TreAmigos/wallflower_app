require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#my_group" do
    context "when user has a group" do
      let(:with_current_group) { create(:group) }
      let(:with_preferred_group) { create(:group) }
      let(:user) { create(:user, preferred_group_id: with_preferred_group.id) }
      let!(:group_membership) { create(:group_membership, user_id: user.id, group_id: with_current_group.id) }
      let!(:group_membership2) { create(:group_membership, user_id: user.id, group_id: with_preferred_group.id) }

      context "when user has current group" do
        let!(:current_group) { create(:current_group, user_id: user.id, group_id: with_current_group.id) }

        it "returns the name of the group" do
          expect(user.my_group).to eq(with_current_group.name)
        end
      end

      context "when no current group set" do
        context "when preferred group id is set" do
          it "returns group2 name" do
            expect(user.my_group).to eq(with_preferred_group.name)
          end
        end

        context "when no preferred group id is set" do
          before do
            user.update_attributes(preferred_group_id: nil)
          end

          it "chooses first group associated with user" do
            expect(user.my_group).to eq(user.groups.first.name)
          end
        end
      end
    end

    context "when user has no group" do
      let(:user) { create(:user) }

      it "returns default no group message" do
        expect(user.my_group).to eq(User::DEFAULT_NO_GROUP_MESSAGE)
      end
    end
  end
end

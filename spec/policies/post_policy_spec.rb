require "rails_helper"

describe PostPolicy do
  subject { described_class }

  permissions :update?, :edit? do
    it "denies access if user isn't author" do
      post = create(:post)
      other_user = create(:user, email: "other_user@example.com")

      expect(subject).not_to permit(other_user, post)
    end

    it "grants access if user is author" do
      post = create(:post)
      expect(subject).to permit(post.user, post)
    end
  end
end
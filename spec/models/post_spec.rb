require 'spec_helper'

describe "Posts" do
  describe Posts::Post do
    subject { create :post, user: other }
    include_examples "valid record" 
    let(:other) { create :user }
    let(:user) { create :user }

    describe "post_blacklist" do
      before do
        user.make_friend_with(other).save
        create :post, user: other
      end 
      it "friends' post display in #with_friends" do
        Posts::Post.with_friends(user).should have(1).items
      end
      it "#add_to_post_blacklist, doesn't display in #with_friends" do
        user.add_to_post_blacklist(other).save
        Posts::Post.with_friends(user).should be_empty
      end
    end
  end

  describe Posts::Comment do
    subject { create :comment }
    include_examples "valid record" 
  end

  describe Posts::Club do
    subject { Posts::Club.with_user(user) }
    let(:user) { create :user }
    include_examples "valid record"
  end
end

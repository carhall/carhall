require 'spec_helper'

describe "Posts" do
  include_context "shared context"

  describe Api::Posts::PostsController do
    let(:resource) { :post }

    context do
      before { 3.times { create resource, user: user }}
      include_examples "resources#index"

      describe "GET club" do
        include_examples "resources#collection", :club
      end

      describe "GET top" do
        include_examples "resources#collection", :top
      end

      describe "with user_id" do
        let(:args) {{ user_id: user.id }}
        include_examples "resources#collection", :index
      end
    end

    describe "GET friends" do
      before { user.make_friend_with(other).save }
      before { 3.times { create resource, user: other }}
      include_examples "resources#collection", :friends
    end

    include_examples "resources#show"
    include_examples "resources#create"

    describe "when post belongs to self" do
      let(:append_attrs_when_build) {{ user: user }}
      include_examples "resources#destroy"
    end

    describe "when comment belongs to other" do
      let(:append_attrs_when_build) {{ user: other }}
      include_examples "resources#destroy failed"
    end

    describe "when other in post blacklist" do
      before { user.add_to_post_blacklist(other).save }

      describe "GET friends" do
        before { user.make_friend_with(other).save }
        before { 3.times { create resource, user: other }}
        include_examples "resources#collection empty", :friends
      end
    end
  end

  describe Api::CommentsController do
    let(:resource) { :comment }
    let(:user_post) { create :post, user: user }
    let(:other_post) { create :post, user: user }

    describe "when post belongs to self" do
      let(:append_args) {{ post_id: user_post.id }}
      let(:append_attrs_when_build) {{ source: user_post, user: user }}
      include_examples "resources#index"
      include_examples "resources#show"
      include_examples "resources#create"
      include_examples "resources#destroy"
    end

    describe "when post belongs to other" do
      let(:append_args) {{ post_id: other_post.id }}
      let(:append_attrs_when_build) {{ source: other_post, user: user }}
      include_examples "resources#index"
      include_examples "resources#show"
      include_examples "resources#create"
      include_examples "resources#destroy"
    end

    describe "when comment belongs to other" do
      let(:append_args) {{ post_id: other_post.id }}
      let(:append_attrs_when_build) {{ source: other_post, user: other }}
      include_examples "resources#destroy failed"
    end
  end

  describe Api::Posts::PostBlacklistsController do

    describe "GET index" do
      before { 3.times { user.add_to_post_blacklist(create(:user)).save }}
      include_examples "resources#collection", :index
    end
    
    describe "POST create" do
      let(:args) {{ id: other.id }}
      include_examples "resources#post", :create
    end
    
    describe "when other in post blacklist" do
      before { user.add_to_post_blacklist(other).save }

      describe "DELETE destroy" do
        let(:args) {{ id: other.id }}
        include_examples "resources#delete", :destroy
      end
    end
  end

  describe Api::Posts::ClubsController do
    let(:resource) { :club }

    include_examples "resource#show"

    describe "POST president" do
      let(:append_args) {{ data: { description: 'Test' }}}
      include_examples "resources#post", :president
    end
    
    describe "POST mechanics" do
      let(:append_args) {{ data: { description: 'Test' }}}
      include_examples "resources#post", :mechanics
    end
    
    describe "when user isn't president" do
      include_examples "resources#update failed"
    end
    
    describe "when user is president" do
      before { user.club.appoint_president! user }
      include_examples "resource#update"
    end
  end
end

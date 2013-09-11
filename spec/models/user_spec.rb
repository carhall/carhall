require 'spec_helper'

describe User do
  subject { create :user }
  include_examples "valid record"

  let(:other) { create :user }

  describe "friends" do
    it "#make_friend_with other" do
      subject.make_friend_with(other).should be_valid
    end
    it "not #make_friend_with himself" do
      subject.make_friend_with(subject).should_not be_valid
    end
    it "#make_friend_with other twice" do
      subject.make_friend_with(other).save
      subject.make_friend_with(other).should be_valid
    end
    it "#break_with other" do
      subject.make_friend_with(other).save
      subject.break_with(other).should be_valid
    end
    it "when other is not friend, #break_with other" do
      subject.break_with(other).should be_nil
    end
  end

  describe "blacklist" do
    it "#add_to_blacklist other" do
      subject.add_to_blacklist(other).should be_valid
    end
    it "#add_to_blacklist other twice" do
      subject.add_to_blacklist(other).save
      subject.add_to_blacklist(other).should be_valid
    end
    it "when other in blacklist, not #make_friend_with other" do
      subject.add_to_blacklist(other).save
      subject.make_friend_with(other).should_not be_valid
    end
    it "#remove_from_blacklist other" do
      subject.add_to_blacklist(other).save
      subject.remove_from_blacklist(other.id).should be_valid
    end
    it "when other not in blacklist, #remove_from_blacklist other" do
      subject.remove_from_blacklist(other.id).should be_nil
    end
  end

  describe "post_blacklist" do
    it "#add_to_post_blacklist other" do
      subject.add_to_post_blacklist(other).should be_valid
    end
    it "#add_to_post_blacklist other twice" do
      subject.add_to_post_blacklist(other).save
      subject.add_to_post_blacklist(other).should be_valid
    end
    it "#remove_from_post_blacklist other" do
      subject.add_to_post_blacklist(other).save
      subject.remove_from_post_blacklist(other.id).should be_valid
    end
    it "when other not in blacklist, #remove_from_post_blacklist other" do
      subject.remove_from_post_blacklist(other.id).should be_nil
    end
  end
end

describe Dealer do
  subject { create :dealer }
  include_examples "valid record" 

end

describe Provider do
  subject { create :provider }
  include_examples "valid record" 

end

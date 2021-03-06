require 'test_helper'

class ContentTest < ActionView::TestCase
  test "index_for#content accepts any object" do
    with_content_for @user, "Special content"
    assert_select "div.index_for", "Special content"
  end

  test "index_for#content accepts :if_blank as option" do
     with_content_for @user, "", :if_blank => "Got blank"
     assert_select "div.index_for", "Got blank"
   end

  test "index_for#content accepts html options" do
    with_content_for @user, "Special content", :content_tag => :b, :id => "thecontent", :class => "special"
    assert_select "div.index_for b#thecontent.special.content", "Special content"
    assert_no_select "div.index_for b[content_tag]"
  end

  test "index_for#content with blank value has a 'no value'-class" do
    swap IndexFor, :blank_content_class => "nothing" do
      with_content_for @user, nil, :content_tag => :b
      assert_select "div.index_for b.nothing"
    end
  end
end

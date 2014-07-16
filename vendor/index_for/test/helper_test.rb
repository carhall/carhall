require "test_helper"

class CustomBuilder < IndexFor::Builder
end

class HelperTest < ActionView::TestCase
  test "show for yields an instance of IndexFor::Builder" do
    index_for(@user) do |f|
      assert f.instance_of?(IndexFor::Builder)
    end
  end

  test "show for yields an instance of builder class specified by builder option" do
    index_for(@user, :builder => CustomBuilder) do |f|
      assert f.instance_of?(CustomBuilder)
    end
  end

  test "show for should add default class to form" do
    concat(index_for(@user) do |f| end)
    assert_select "div.index_for"
  end

  test "show for should add object class name as css class to form" do
    concat(index_for(@user) do |f| end)
    assert_select "div.index_for.user"
  end

  test "show for should pass options" do
    concat(index_for(@user, :id => "my_div", :class => "common") do |f| end)
    assert_select "div#my_div.index_for.user.common"
  end

  test "show for tag should be configurable" do
    swap IndexFor, :index_for_tag => :p do
      concat(index_for(@user) do |f| end)
      assert_select "p.index_for"
    end
  end

  test "show for class should be configurable" do
    swap IndexFor, :index_for_class => :awesome do
      concat(index_for(@user) do |f| end)
      assert_select "div.index_for.user.awesome"
    end
  end
  
  test "show for options hash should not be modified" do
    html_options = { :index_for_tag => :li }
    concat(index_for(@user, html_options) do |f| end)
    assert_equal({ :index_for_tag => :li }, html_options)
  end
  
end

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal 'PostU', full_title
    assert_equal 'Help | PostU', full_title("Help")
  end
end
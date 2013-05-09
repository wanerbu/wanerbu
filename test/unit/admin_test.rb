require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  ### validates test
  test "should not save without login id" do
    admin = Admin.new
    assert !admin.save
  end
end

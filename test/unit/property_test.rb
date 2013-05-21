require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  test "should not save property without name" do
    property = Property.new
    assert !property.save
    assert_equal 2, property.errors[:name].length
    assert_equal I18n.t('errors.messages.blank'), property.errors[:name][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 1}), property.errors[:name][1]
  end
end

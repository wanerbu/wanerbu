require 'test_helper'

class SportTest < ActiveSupport::TestCase
  test "should not save sport without name" do
    sport = Sport.new
    assert !sport.save
    assert_equal 2, sport.errors[:name].length
    assert_equal I18n.t('errors.messages.blank'), sport.errors[:name][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 1}), sport.errors[:name][1]
  end
end

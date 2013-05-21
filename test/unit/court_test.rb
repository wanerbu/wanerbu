require 'test_helper'

class CourtTest < ActiveSupport::TestCase
  test "should not save gym without sport_id" do
    court = Court.new
    assert !court.save
    assert_equal 1, court.errors[:sport_id].length
    assert_equal I18n.t('errors.messages.blank'), court.errors[:sport_id][0]
  end
end

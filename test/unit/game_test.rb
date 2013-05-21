require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "should not save game without name" do
    game = Game.new
    assert !game.save
    assert_equal 2, game.errors[:name].length
    assert_equal I18n.t('errors.messages.blank'), game.errors[:name][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 1}), game.errors[:name][1]
  end
end

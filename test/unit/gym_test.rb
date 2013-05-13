require 'test_helper'
class GymTest < ActiveSupport::TestCase

  test "should not save gym without name" do
    gym = Gym.new
    assert !gym.save
    assert_equal 2, gym.errors[:name].length
    assert_equal I18n.t('errors.messages.blank'), gym.errors[:name][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 1}), gym.errors[:name][1]
  end

  test "should not save gym when name  length greater than 50" do
    gym = Gym.new
    gym.name = '123456789012345678901234567890123456789012345678901'
    assert !gym.save
    assert_equal 1, gym.errors[:name].length
    assert_equal I18n.t('errors.messages.too_long', {count: 50}), gym.errors[:name][0]
  end

  test "should not save gym without intro" do
    gym = Gym.new
    assert !gym.save
    assert_equal 2, gym.errors[:intro].length
    assert_equal I18n.t('errors.messages.blank'), gym.errors[:intro][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 6}), gym.errors[:intro][1]
  end

  test "should not save gym when intro length less than 6" do
    gym = Gym.new
    gym.intro = 'abcde'
    assert !gym.save
    assert_equal 1, gym.errors[:intro].length
    assert_equal I18n.t('errors.messages.too_short', {count: 6}), gym.errors[:intro][0]
  end

  test "should not save gym without address" do
    gym = Gym.new
    assert !gym.save
    assert_equal 2, gym.errors[:address].length
    assert_equal I18n.t('errors.messages.blank'), gym.errors[:address][0]
    assert_equal I18n.t('errors.messages.too_short', {count: 1}), gym.errors[:address][1]
  end

  test "should not save gym when address length greater than 50" do
    gym = Gym.new
    gym.address = '123456789012345678901234567890123456789012345678901'
    assert !gym.save
    assert_equal 1, gym.errors[:address].length
    assert_equal I18n.t('errors.messages.too_long', {count: 50}), gym.errors[:address][0]
  end

  test "should not save gym when telephone no length greater than 15 or include star mark" do
    gym = Gym.new
    gym.telephone = '123456789012345*'
    assert !gym.save
    assert_equal 2, gym.errors[:telephone].length
    assert_equal I18n.t('errors.messages.too_long', {count: 15}), gym.errors[:telephone][0]
    #assert_equal I18n.t('errors.messages.invalid'), gym.errors[:telephone][1]
  end

  test "should not save gym without open_time" do
    gym = Gym.new
    assert !gym.save
    assert_equal 1, gym.errors[:open_time].length
    assert_equal I18n.t('errors.messages.blank'), gym.errors[:open_time][0]
  end

  test "should not save gym without close_time" do
    gym = Gym.new
    assert !gym.save
    assert_equal 1, gym.errors[:close_time].length
    assert_equal I18n.t('errors.messages.blank'), gym.errors[:close_time][0]
  end

  test "should not save gym when close_time <= open_time" do
    gym = Gym.new
    gym.close_time = "2000-01-01 11:59:02"
    gym.open_time = "2000-01-01 11:59:02"
    assert !gym.save
    assert_equal 1, gym.errors[:close_time].length
    assert_equal 'close_time <= open_time', gym.errors[:close_time][0]
  end

end

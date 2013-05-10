require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  ### validates test
  test "should not save admin without login id" do
    admin = Admin.new
    assert !admin.save
    assert_equal 1, admin.errors[:login_id].length
    assert_equal I18n.t('errors.messages.blank'), admin.errors[:login_id][0]
  end

  test "should not save admin when login id length less than 6" do
    admin = Admin.new
    admin.login_id = 'abcde'
    assert !admin.save
    assert_equal 1, admin.errors[:login_id].length
    assert_equal I18n.t('errors.messages.too_short', {count: 6}), admin.errors[:login_id][0]
  end

  test "should not save admin when login id length greater than 16" do
    admin = Admin.new
    admin.login_id = '12345678901234567'
    assert !admin.save
    assert_equal 1, admin.errors[:login_id].length
    assert_equal I18n.t('errors.messages.too_long', {count: 16}), admin.errors[:login_id][0]
  end

  test "should not save admin when login id include star mark" do
    admin = Admin.new
    admin.login_id = 'abcdef*'
    assert !admin.save
    assert_equal 1, admin.errors[:login_id].length
    assert_equal I18n.t('activerecord.errors.models.admin.attributes.login_id.invalid'), admin.errors[:login_id][0]
  end

  test "should not save admin when first name or last name length greater than 10" do
    admin = Admin.new
    admin.first_name = '1234567890*'
    admin.last_name = '1234567890*'
    assert !admin.save
    assert_equal 1, admin.errors[:first_name].length
    assert_equal I18n.t('errors.messages.too_long', {count: 10}), admin.errors[:first_name][0]

    assert_equal 1, admin.errors[:last_name].length
    assert_equal I18n.t('errors.messages.too_long', {count: 10}), admin.errors[:last_name][0]
  end

  test "should not save admin when telephone no length greater than 15 or include star mark" do
    admin = Admin.new
    admin.telephone_no = '123456789012345*'
    assert !admin.save
    assert_equal 2, admin.errors[:telephone_no].length
    assert_equal I18n.t('errors.messages.too_long', {count: 15}), admin.errors[:telephone_no][0]
    assert_equal I18n.t('errors.messages.invalid'), admin.errors[:telephone_no][1]
  end

  test "should not save admin when status invalid" do
    admin = Admin.new
    admin.status = 'XX'
    assert !admin.save
    assert_equal 1, admin.errors[:status].length
    assert_equal I18n.t('errors.messages.invalid'), admin.errors[:status][0]
  end

  ### method test
  # only_super_admin?
  test "only super admin" do
    assert admins(:only_super_admin).only_super_admin?
    assert !admins(:admin_unconfirmed).only_super_admin?
  end

  # name
  test "name return blank when first and last name is blank" do
    admin = Admin.new
    assert_equal '', admin.name
  end

  test "name return first name when last name is blank" do
    admin = Admin.new
    admin.first_name = 'first'
    assert_equal 'first', admin.name
  end

  test "name return last name when first name is blank" do
    admin = Admin.new
    admin.last_name = 'last'
    assert_equal 'last', admin.name
  end

  test "name return first name + space + last name when first and last name is present" do
    admin = Admin.new
    admin.first_name = 'first'
    admin.last_name = 'last'
    assert_equal 'first last', admin.name
  end

  # ability?(function)
  test "only super admin has all abilities" do
    assert admins(:only_super_admin).ability?(:all)
    assert !admins(:admin_unconfirmed).ability?(:all)
  end

  test "has ability to manage gyms when has the related role" do
    assert admins(:admin_operator).ability?(:approve_reject_gym)
  end

end

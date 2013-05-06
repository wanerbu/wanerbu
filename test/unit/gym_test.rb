require 'test_helper'

class GymTest < ActiveSupport::TestCase
  test "should not save gym without name" do
    @gym = Gym.new
    assert !@gym.save,"same a gym without name"
  end
end

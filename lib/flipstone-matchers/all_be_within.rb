RSpec::Matchers.define :all_be_within do |allowable_delta|
  chain :of do |expected_array|
    @expected_array = expected_array
  end

  def within?(left, right, delta)
    (left - right).abs < delta
  end

  match do |actual_array|
    @expected_array.count == actual_array.count &&
    actual_array.zip(@expected_array).all? { |left, right| within?(left, right, allowable_delta)}
  end

  failure_message_for_should do |actual_array|
    "Expected all of #{actual_array} to be within #{allowable_delta} of #{@expected_array}"
  end
end


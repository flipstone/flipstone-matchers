RSpec::Matchers.define :be_same_set_as do |expected|
  match do |actual|
    Set.new(actual) == Set.new(expected)
  end

  failure_message_for_should do |actual|
    <<-message
expected #{actual.inspect} have same set of elements as #{expected.inspect}.
  actual values: #{actual.to_a.inspect}
expected values: #{expected.to_a.inspect}
    message
  end
end

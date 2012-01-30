RSpec::Matchers.define :be_in_order_by do |expression, options = {}|
  match do |actual|
    @values_to_be_sorted_by = actual.map do |o|
      o.instance_eval expression
    end

    @sorted = @values_to_be_sorted_by.sort

    if options[:descending]
      @sorted = @sorted.reverse
    end

    @sorted == @values_to_be_sorted_by
  end

  failure_message_for_should do |actual|
    <<-end_message
Expected items to be in order by #{expression}
Expected: #{@sorted}
Actual:   #{@values_to_be_sorted_by}
    end_message
  end
end


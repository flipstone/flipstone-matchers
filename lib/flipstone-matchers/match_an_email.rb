RSpec::Matchers.define :match_an_email do
  chain :subject do
    @email_field = :subject
  end

  chain :body do
    @email_field = :body
  end

  chain :just_one do
    @count = 1
  end

  chain :to do |user|
    @to_email = user.email
  end

  match do |actual|
    actual = [actual] unless actual.is_a?(Array)
    matchers = actual.map do |actual|
      case actual
      when String then /#{actual}/
      else actual
      end
    end

    @all_fields = ActionMailer::Base.deliveries.select do |email|
      @to_email.nil? || email.to.include?(@to_email)
    end.map(&@email_field)

    @matches = @all_fields.select do |value|
      matchers.all? { |matcher| matcher === value.to_s }
    end

    @count_matches = true

    if @count
      matched = @matches.size == @count
    else
      matched = @matches.any?
    end

    @email_field && matched
  end

  failure_message_for_should do |actual|
    if @email_field.blank?
      "No email field specified. Did you mean should match_an_email.subject ?"
    elsif @count
      message = []
      message << "Expected #{@count} #{@to_email} emails with #{@email_field} matching #{actual}"
      message << "Matching fields were: ["
      message << "  " + @matches.join(",\n  ")
      message << "]"
      message.join("\n")
    else
      message = []
      message << "Found no email with #{@email_field} matching #{actual}"
      message << "Actual message fields were: ["
      message << "  " + @all_fields.join(",\n  ")
      message << "]"
      message.join("\n")
    end
  end

  failure_message_for_should_not do |actual|
    message = []
    message << "Found #{@to_email} email with #{@email_field} matching #{actual}"
    message << "The matching items where: ["
    message << "  " + @matches.join(",\n  ")
    message << "]"
    message.join("\n")
  end
end


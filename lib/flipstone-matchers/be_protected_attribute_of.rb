RSpec::Matchers.define :be_protected_attribute_of do |model_class, value|
  match do |attribute|
    new_instance = model_class.new attribute => value
    @mass_assignable = (new_instance.send(attribute) == value)

    saved_instance = model_class.new
    saved_instance.update_protected_attributes(
      Factory.attributes_for(model_class.name.underscore,
                             attribute => value)
    )

    @updateable = (saved_instance.send(attribute) == value)

    clear_instance = model_class.new
    clear_instance.send("#{attribute}=", value)
    clear_instance.update_protected_attributes({})

    @cleared_without_request = (clear_instance.send(attribute) != value)

    !@mass_assignable && @updateable && !@cleared_without_request
  end

  failure_message_for_should do |attribute|
    errors = ["Expected #{attribute} to be a protected attribute"]

    if @mass_assignable
      errors << "  But it was mass assignable via hash"
    end

    if !@updateable
      errors << "  But it was not updateable via update_protected_attributes"
    end

    if @cleared_without_request
      errors << "  But it was cleared out by update_protected_attributes({})"
    end

    errors.join("\n")
  end
end


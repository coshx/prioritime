RSpec::Matchers.define :act_as_superclass do
  match do |subject|
    begin
      subject.send(:specific)
      true
    rescue NoMethodError => e
      false
    end
  end
end

RSpec::Matchers.define :act_as_role do
  match do |subject|
    begin
      subject.send(:role)
      subject.send(:user)
      subject.send(:organization)
      true
    rescue NoMethodError => e
      false
    end
  end
end

RSpec::Matchers.define :have_timestamps do
  match do |subject|
    Shoulda::Matchers::ActiveRecord::HaveDbColumnMatcher
      .new(:created_at)
      .of_type(:datetime)
      .matches?(subject)

    Shoulda::Matchers::ActiveRecord::HaveDbColumnMatcher
      .new(:updated_at)
      .of_type(:datetime)
      .matches?(subject)
  end
end

RSpec::Matchers.define :authorize do |action|
  match do |policy|
    policy.public_send("#{action}?")
  end

  failure_message_for_should do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.inspect}."
  end

  failure_message_for_should_not do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.inspect}."
  end
end
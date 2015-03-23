def stub_authorization
  allow_any_instance_of(policy).to receive(authorization).and_return(true)
end
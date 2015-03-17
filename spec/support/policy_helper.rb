def stub_authorization
  policy.any_instance.stub(authorization).and_return(true)
end
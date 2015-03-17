shared_examples :authorization_required_route do
  it "denies requests that fail authorization" do
    policy.any_instance.stub(authorization).and_return(false)
    make_request(route[:type], route[:url], {}, authenticated_json_header(user))
    expect(response).to be_unauthorized
    expect(response.body).to eql("You are not authorized to perform this action.")
  end
end
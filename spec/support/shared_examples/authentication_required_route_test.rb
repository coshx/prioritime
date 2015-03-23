shared_examples :authentication_required_route do
  it "denies requests with wrong token" do
    make_request(route[:type], route[:url], {}, wrong_token_json_header(user))
    expect(response).to be_unauthorized
    expect(response.body).to eql("You need to sign in.")
  end
end

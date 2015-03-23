require 'rails_helper'

RSpec.describe "Projects destroy", type: :request do
  let(:route) { { type: :delete, url: project_path(organization_id: organization, id: project.id) } }

  let(:policy) { ProjectPolicy }
  let(:authorization) { :destroy? }

  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  let(:project) { create(:project, organization: organization) }
  
  it_behaves_like :authentication_required_route
  it_behaves_like :authorization_required_route

  it "deletes the project" do
    stub_authorization()
    delete_request({})

    expect(response).to be_success
    expect(Project.last).to be_nil
  end
end
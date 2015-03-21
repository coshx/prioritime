require 'rails_helper'

describe ProjectsController do
  let!(:organization) { create(:organization) }
  let!(:user) { create(:user) }
  let!(:admin) { Admin.create(organization: organization, user: user) }

  describe "GET index" do
    let!(:project1) { create :project, organization: organization }
    let!(:project2) { create :project, organization: organization }
    let!(:other_project) { create :project }
    let(:route) { { type: :get, url: projects_path(organization) } }

    before do
      get(route[:url], {}, authenticated_json_header(user))
    end

    context "authentication" do
      it_behaves_like :authentication_required_route
    end

    context "when the user is authorized" do
      it "gets the projects of the signed in user" do
        expect(response).to be_success
        expect(response).to be_in_json
        project_ids = json(response.body)[:projects].map { |p| p[:id] }
        expect(project_ids). to eq [project1.id, project2.id]
      end
    end
  end

  describe "GET show" do
    let!(:project) { create :project, organization: organization }
    let(:route) { { type: :get, url: project_path(organization, project)} }

    before do
      get(route[:url], {}, authenticated_json_header(user))
    end

    context "authentication" do
      it_behaves_like :authentication_required_route
    end

    context "when the user is authorized" do
      it "should return the correct project" do
        expect(response).to be_success
        expect(response).to be_in_json
        expect(json(response.body)[:project][:id]).to eq project.id
      end
    end
  end

  describe "POST create" do
    let(:route) { { type: :post, url: projects_path(organization) } }
    let!(:new_project) { create(:project, organization: organization) }
    let(:post_params) { { project: new_project.attributes } }

    before do
      post(route[:url], post_params, authenticated_json_header(user))
    end

    context "authentication" do
      it_behaves_like :authentication_required_route
    end

    context "when the user is authorized" do
      it "should create a new project" do
        expect(response).to be_success
        expect(response).to be_in_json
        expect(json(response.body)[:project][:name]).to eq new_project.name
      end
    end
  end

  describe "PUT update" do
    let!(:project) { create :project, organization: organization }
    let(:route) { { type: :patch, url: project_path(organization, project) } }

    before do
      patch(route[:url], { project: { name: "Strange Project" } },
        authenticated_json_header(user))
    end

    context "authentication" do
      it_behaves_like :authentication_required_route
    end

    context "when the user is authorized" do
      it "updates the project" do
        expect(response).to be_success
        expect(response).to be_in_json
        expect(json(response.body)[:project][:name]).to eq "Strange Project"
      end
    end
  end

  describe "DELETE destroy" do
    let!(:project) { create :project, organization: organization }
    let(:route) { { type: :delete, url: project_path(organization, project) } }

    before do
      delete(route[:url], {}, authenticated_json_header(user))
    end

    context "authentication" do
      it_behaves_like :authentication_required_route
    end

    context "when the user is authorized" do
      it "should destroy the project" do
        expect(response).to be_success
        expect(Project.where(id: project.id)).to be_empty
      end
    end
  end
end

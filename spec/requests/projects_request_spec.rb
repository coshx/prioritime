require 'rails_helper'

describe ProjectsController do
  let(:user) { create :user }

  describe "GET index" do
    let(:route) { { type: :get, url: projects_path } }

    it_behaves_like :authentication_required_route


    context "user signed in" do
      let!(:project1) { create :project, user: user }
      let!(:project2) { create :project, user: user }
      let!(:other_project) { create :project }

      it "gets the projects of the signed in user" do
        get(route[:url], {}, authenticated_json_header(user))

        expect(response).to be_success
        expect(response).to be_in_json

        projects_response = json(response.body)[:projects]
        expect(projects_response.count).to eq(2)
        expect(projects_response.first[:id]).to eq(project2.id)
        expect(projects_response.last[:id]).to eq(project1.id)
      end
    end
  end

  describe "GET show" do
    let(:project) { create :project, user: user }
    let(:route) { { type: :get, url: project_path(project)}}

    it_behaves_like :authentication_required_route

    it "gets the user specifed" do
      get(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      project_response = json(response.body)[:project]
      expect(project_response[:id]).to eql(project.id)
    end
  end

  describe "POST create" do
    let(:route) { { type: :post, url: projects_path } }

    it_behaves_like :authentication_required_route

    it "creates a new project for the user" do
      post(route[:url], { project: { name: "Big Money", duration_weeks: "8",
          description: "Probably will make lots of money" } }, 
          authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      new_project_response = json(response.body)[:project]
      expect(new_project_response[:name]).to eql("Big Money")
      expect(user.projects.last.name).to eql("Big Money")      
    end
  end

  describe "PUT update" do
    let(:project) { create :project, user: user }
    let(:route) { { type: :patch, url: project_path(project) } }

    it_behaves_like :authentication_required_route

    it "lets you update the project" do
      patch(route[:url], { project: { name: "Strange Project" } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      updated_project_response = json(response.body)[:project]
      expect(updated_project_response[:name]).to eql("Strange Project")

      p = user.projects.last
      expect(p.name).to eq("Strange Project")
    end
  end

  describe "DELETE destroy" do
    let(:route) { { type: :delete, url: project_path(id: project.id) } }
    let!(:project) { create :project, user: user }

    it "lets you delete a project" do
      delete(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success

      expect(Project.where(id: project.id)).to be_empty
    end
  end
end

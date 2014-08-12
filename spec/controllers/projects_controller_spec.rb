require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  let(:user) { create :user }

  describe "GET index" do
    context "user not logged in" do
      it "give a not authorized error" do
        get :index, format: :json
        expect(response).to_not be_success
        expect(response.code).to eq("401")
      end
    end

    context "user signed in" do
      let!(:project1) { create :project, user: user }
      let!(:project2) { create :project, user: user }
      let!(:other_project) { create :project }

      before { sign_in user }

      it "gets the projects of the signed in user" do
        get :index, format: :json
        expect(assigns(:projects).count).to eq(2)
        expect(assigns(:projects)).to_not include(other_project)
      end
    end

  end

  describe "GET show" do
    before { sign_in user }
    let(:project) { create :project, user: user }

    it "gets the user specifed" do
      get :show, format: :json, id: project.id
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "POST create" do
    before { sign_in user }

    it "creates a new project for the user" do
      expect {
        post :create, format: :json, project: { name: "Big Money", duration_weeks: "8",
          description: "Probably will make lots of money" }
      }.to change{Project.count}.by(1)

      expect(user.projects.last).to eq(Project.last)
    end
  end

  describe "PUT update" do
    before { sign_in user }
    let(:project) { create :project, user: user }

    it "lets you update the project" do
      put :update, format: :json, id: project.id, project: { name: "Strange Project", client: "Strange Dude" }
      p = user.projects.last
      expect(p.name).to eq("Strange Project")
      expect(p.client).to eq("Strange Dude")
    end
  end

  describe "DELETE destroy" do
    before { sign_in user }
    let!(:project) { create :project, user: user }

    it "lets you delete a project" do
      expect {
        delete :destroy, format: :json, id: project.id
      }.to change{Project.count}.by(-1)

      expect(Project.where(id: project.id)).to be_empty
    end
  end

end

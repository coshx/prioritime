require 'rails_helper'

RSpec.describe PeopleController, :type => :controller do
  let(:user) { create :user }

  describe "GET index" do
    context "user not logged in" do
      it "redirects the user to sign in" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      let!(:person1) { create :person, user: user }
      let!(:person2) { create :person, user: user }
      let!(:other_person) { create :person }

      before { sign_in user }

      it "gets the people of the signed in user" do
        get :index
        expect(assigns(:people).count).to eq(2)
        expect(assigns(:people)).to_not include(other_person)
      end
    end

  end

  describe "GET show" do
    before { sign_in user }
    let(:person) { create :person, user: user }

    it "gets the user specifed" do
      get :show, id: person.id
      expect(assigns(:person)).to eq(person)
    end
  end

  describe "GET edit" do
    before { sign_in user }
    let(:person) { create :person, user: user }

    it "finds the correct person to edit" do
      get :edit, id: person.id
      expect(assigns(:person)).to eq(person)
    end
  end

  describe "POST create" do
    before { sign_in user }

    it "creates a new person for the user" do
      expect {
        post :create, person: { name: "larry wall", title: "perl dude",
          description: "I have no idea why Larry Wall is in a Rails test - what the heck?", hour_capacity: 20 }
      }.to change{Person.count}.by(1)

      expect(user.people.last).to eq(Person.last)
    end
  end

  describe "PUT update" do
    before { sign_in user }
    let(:person) { create :person, user: user }

    it "lets you update the person" do
      put :update, id: person.id, person: { name: "Susan Knowles", title: "CTO" }
      p = user.people.last
      expect(p.name).to eq("Susan Knowles")
      expect(p.title).to eq("CTO")
    end
  end

  describe "DELETE destroy" do
    before { sign_in user }
    let!(:person) { create :person, user: user }

    it "lets you delete a person" do
      expect {
        delete :destroy, id: person.id
      }.to change{Person.count}.by(-1)

      expect(Person.where(id: person.id)).to be_empty
    end
  end

end

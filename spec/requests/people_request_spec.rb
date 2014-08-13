require 'rails_helper'

describe PeopleController do
  let(:user) { create :user }

  describe "GET index" do
    let(:route) { { type: :get, url: people_path } }

    it_behaves_like :authentication_required_route

    context "user signed in" do
      let!(:person1) { create :person, user: user }
      let!(:person2) { create :person, user: user }
      let!(:other_person) { create :person }

      it "gets the people of the signed in user" do
        get(route[:url], {}, authenticated_json_header(user))

        expect(response).to be_success
        expect(response).to be_in_json
      
        people_response = json(response.body)[:people]
        expect(people_response.count).to eq(2)
        expect(people_response.first[:id]).to eql(person2.id)
        expect(people_response.last[:id]).to eql(person1.id)
      end
    end

  end

  describe "GET show" do
    let(:person) { create :person, user: user }
    let(:route) { { type: :get, url: person_path(id: person.id) } }

    it_behaves_like :authentication_required_route
    
    it "gets the user specifed" do
      get(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json
    
      person_response = json(response.body)[:person]
      expect(person_response[:id]).to eql(person.id)
    end
  end

  describe "POST create" do
    let(:route) { { type: :post, url: people_path } }

    it_behaves_like :authentication_required_route

    it "creates a new person for the user" do
      post(route[:url], { person: { name: "larry wall", title: "perl dude",
          description: "I have no idea why Larry Wall is in a Rails test - what the heck?", 
          hour_capacity: 20 } }, authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      new_person_response = json(response.body)[:person]
      expect(new_person_response[:id]).to eql(Person.last.id)
      expect(user.people.last.name).to eql("larry wall")
    end
  end

  describe "PUT update" do
    let(:person) { create :person, user: user }
    let(:route) { { type: :patch, url: person_path(id: person.id) } }
    
    it_behaves_like :authentication_required_route

    it "lets you update the person" do
      patch(route[:url], { person: { name: "Susan Knowles" } }, 
        authenticated_json_header(user))

      expect(response).to be_success
      expect(response).to be_in_json

      updated_person_response = json(response.body)[:person]
      expect(updated_person_response[:name]).to eql("Susan Knowles")

      p = user.people.last
      expect(p.name).to eq("Susan Knowles")
    end
  end

  describe "DELETE destroy" do
    let(:route) { { type: :delete, url: person_path(id: person.id) } }
    let!(:person) { create :person, user: user }

    it "lets you delete a person" do
      delete(route[:url], {}, authenticated_json_header(user))

      expect(response).to be_success

      expect(Person.where(id: person.id)).to be_empty
    end
  end
end

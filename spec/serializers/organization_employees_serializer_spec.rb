require "rails_helper"

describe OrganizationEmployeesSerializer, type: :serializer do
  let!(:organization) { create(:organization) }
  let!(:employee1) { create(:employee, organization: organization) }
  let!(:employee2) { create(:employee, organization: organization) }

  let(:serializer) { OrganizationEmployeesSerializer.new(organization) }

  context "when serializing" do
    it "should have the correct organization information" do
      expect(serializer.id).to eq organization.id
      expect(serializer.name).to eq organization.name
    end

    it "should include the employee information" do
      expect(serializer.associations["employee_ids"]).to \
        eq [employee1.id, employee2.id]
    end
  end
end

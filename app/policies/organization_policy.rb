class OrganizationPolicy
  attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def view?
    user.roles.includes(:organization).where(organization_id: @organization.id).count > 0
  end
end
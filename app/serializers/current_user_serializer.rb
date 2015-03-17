class CurrentUserSerializer < ActiveModel::Serializer
  self.root = :user
  attributes :id, :authentication_token, :email, :roles_with_organization

  def roles_with_organization
    result = []

    object.roles.order(:id).includes(:actable).includes(:organization).each do |role|
      result.push({
        specific_id: role.specific.id,
        name: role.actable_type,
        organization_name: role.organization.name,
        organization_id: role.organization.id
      })
    end
    result
  end
end
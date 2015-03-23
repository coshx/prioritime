class ProjectPolicy < Struct.new(:user, :record)
  def update?
    user.admin_of?(record.organization)
  end

  def destroy?
    user.admin_of?(record.organization)
  end
end


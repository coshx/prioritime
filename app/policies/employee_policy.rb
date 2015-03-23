class EmployeePolicy < Struct.new(:user, :record)
  def update?
    user.admin_of?(record.organization) or record.user_id == user.id
  end

  def destroy?
    user.admin_of?(record.organization)
  end
end
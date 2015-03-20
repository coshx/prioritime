class EmployeePolicy < Struct.new(:user, :record)
  def update?
    user.admin_of?(record.organization) or record.user_id == user.id
  end
end
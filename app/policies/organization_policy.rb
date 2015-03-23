class OrganizationPolicy < Struct.new(:user, :record)
  def view_employees?
    user.part_of?(record)
  end

  def create_employees?
    user.admin_of?(record)
  end

  def view_projects?
    user.part_of?(record)
  end

  def create_projects?
    user.admin_of?(record)
  end
end

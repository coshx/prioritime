class ProjectPolicy < Struct.new(:user, :record)

  def new?
    record.can_user_access?(user)
  end

  def create?
    record.can_user_access?(user)
  end

  def show?
    record.can_user_access?(user)
  end

  def index?
    record.can_user_access?(user)
  end

  def edit?
    record.can_user_access?(user)
  end

  def update?
    record.can_user_access?(user)
  end

  def destroy?
    record.can_user_access?(user)
  end

  def view?
    user.roles.includes(:organization).where(organization_id: record.id).count > 0
  end
end


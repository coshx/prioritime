class CurrentUserSerializer < ActiveModel::Serializer
  self.root = :user
  attributes :id, :authentication_token, :email
end
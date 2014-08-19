class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def is_collaborator?(user)
    users.include? user
  end
end

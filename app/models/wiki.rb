class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def is_collaborator?(user)
    users.include? user
  end

  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end

  scope :visible_to, -> (user) {user ? all : where(private: false) }
end

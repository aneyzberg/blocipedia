class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  #def should_generate_new_friendly_id?
    #new_record?
  #end

  def is_collaborator?(user)
    users.include? user
  end

  def collaborator_for(user)
    collaborators.where(user_id: user.id).first
  end

  scope :visible_to, -> (user) {user.premium? ? all : where("private IS NULL or private = ?", false) }
end

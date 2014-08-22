module CollaboratorsHelper
  def collaborator_id_for(wiki, user)
    wiki.collaborator_for(user)
  end
end

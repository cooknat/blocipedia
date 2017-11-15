class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators
  
  default_scope { order('created_at DESC') }
  
  #need to sort these out so they deal with multiples
  def hasCollaborators
     Collaborator.where(wiki: self).first
  end
  
  def getCollaborators
      collabs_arr = Collaborator.where(wiki: self).to_a
      # Collaborator.where(wiki: self).to_a.each do |c|
       #  p User.where(id: c.user_id).first.username
     # end      
  end      
end

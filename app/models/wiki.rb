class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators
  
  default_scope { order('created_at DESC') }
  
 
  def collaborators
    collabs_arr = Collaborator.where(wiki: self).to_a
  end      
end

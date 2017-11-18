class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  after_initialize { self.role ||= :standard }
  enum role: [:standard, :premium, :admin]
  
  has_many :wikis
  has_many :collaborators
  # we need a different name for this association since
  # `has_many :wikis` is already taken.  This is one way to do it:
  has_many :wiki_collaborations, through: :collaborators, source: :wiki
  
  def collaborators
     Collaborator.find(user_id)
   end
   
   
end

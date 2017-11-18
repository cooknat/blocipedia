class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki
  
  delegate :username, to: :user
end  


class Post < ActiveRecord::Base

  validates_presence_of :name
  belongs_to :project
  default_scope { where(project_id: Project.current_id) }
end

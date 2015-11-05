class Post < ActiveRecord::Base

  belongs_to :project
  default_scope { where(project_id: Project.current_id) }
end

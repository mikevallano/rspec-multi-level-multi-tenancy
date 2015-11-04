json.array!(@projects) do |project|
  json.extract! project, :id, :name, :description, :account_id
  json.url project_url(project, format: :json)
end

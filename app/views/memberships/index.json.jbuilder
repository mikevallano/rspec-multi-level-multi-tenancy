json.array!(@memberships) do |membership|
  json.extract! membership, :id, :user_id, :account_id
  json.url membership_url(membership, format: :json)
end

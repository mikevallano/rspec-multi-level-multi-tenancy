json.array!(@memberinvites) do |memberinvite|
  json.extract! memberinvite, :id, :email, :receiver_id, :sender_id, :memberinvite_token, :account_id
  json.url memberinvite_url(memberinvite, format: :json)
end

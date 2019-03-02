json.extract! session, :id, :name, :group_id, :created_at, :updated_at
json.url session_url(session, format: :json)

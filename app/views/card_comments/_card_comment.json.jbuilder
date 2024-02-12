json.extract! card_comment, :id, :text, :card_id, :auth_id, :created_at, :updated_at
json.url card_comment_url(card_comment, format: :json)

json.extract! order, :id, :user_id, :total_amount, :state, :created_at, :updated_at
json.url order_url(order, format: :json)

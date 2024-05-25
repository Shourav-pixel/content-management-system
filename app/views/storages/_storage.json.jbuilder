json.extract! storage, :id, :name, :description, :image_data, :user_id, :category_id, :created_at, :updated_at
json.url storage_url(storage, format: :json)

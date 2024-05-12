json.extract! book, :id, :title, :description, :image_data, :author, :synopsis, :published_on, :created_at, :updated_at
json.url book_url(book, format: :json)

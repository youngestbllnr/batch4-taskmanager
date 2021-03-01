json.extract! task, :id, :category_id, :title, :description, :due_date, :is_checked, :created_at, :updated_at
json.url task_url(task, format: :json)

json.extract! user, :id, :email, :lastname, :name, :gender, :phone, :address, :student, :city_id, :adminlevel, :israelid, :healthcheck, :created_at, :updated_at
json.url user_url(user, format: :json)

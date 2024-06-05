# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#管理者
Admin.create!(
   email: 'admin@admin',
   password: 'password'
)

#ユーザー
User.create!(
  email: 'example@example.com',
  password: 'password',
  name: 'John Doe',
  introduction: 'Hello, I am John Doe.',
  is_active: true
)

User.create!(
  email: 'test@test.com',
  password: 'password',
  name: 'Jane Smith',
  introduction: 'Nice to meet you!',
  is_active: true
)

puts '初期データを追加しました。'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#管理者
Admin.find_or_create!(
   email: 'admin@admin',
   password: 'password'
)

#ユーザー
user = User.find_or_create!(
  email: 'example@example.com',
  password: 'password',
  name: 'John Doe',
  introduction: 'Hello, I am John Doe.',
  is_active: true
)

user = User.find_or_create!(
  email: 'test@test.com',
  password: 'password',
  name: 'Jane Smith',
  introduction: 'Nice to meet you!',
  is_active: true
)

user.image.attach(
  io: File.open(Rails.root.join('app', 'assets', 'images', 'Jane_Smith.jpg')),
  filename: 'Jane_Smith.jpg'
)


#育成記録サンプル
cactus_diary = PlantDiary.find_or_create!(
  user_id: 1,
  title: "サボテンの成長記録",
  content: "サボテンの成長過程を記録しています。日光の当て方や水やりの頻度、土の乾き具合などをメモしています。"
)

cactus_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cactus.jpg')), filename: 'cactus.jpg')

ficus_diary = PlantDiary.find_or_create!(
  user_id: 1,
  title: "フィカス(ゴムの木)の日々の変化",
  content: "フィカスの葉の色や状態の変化を定期的に記録しています。光の当たり方や水やりのタイミングなども一緒にメモしています。"
)

ficus_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ficus.jpg')), filename: 'ficus.jpg')

schefflera_diary = PlantDiary.find_or_create!(
  user_id: 2,
  title: "シェフレラの生育記録",
  content: "シェフレラの育成についての詳細なメモです。新しい葉が出るサイクルや土の交換時期などを記録しています。"
)

schefflera_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'schefflera.jpg')), filename: 'schefflera.jpg')

green_bean_diary = PlantDiary.find_or_create!(
  user_id: 1,
  title: "グリーンビーンの成長記録",
  content: "グリーンビーンの種を植えてからの成長過程を記録しています。初めての挑戦なのでどうなるかドキドキです！"
)

puts '初期データを追加しました。'
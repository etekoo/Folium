# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

# ユーザー
user1 = User.find_or_create_by!(email: 'example@example.com') do |user|
  user.password = 'password'
  user.name = 'John Doe'
  user.introduction = 'Hello, I am John Doe.'
  user.is_active = true
end

user2 = User.find_or_create_by!(email: 'test@test.com') do |user|
  user.password = 'password'
  user.name = 'Jane Smith'
  user.introduction = 'Nice to meet you!'
  user.is_active = true
end

# 添付ファイルの確認と添付
if File.exist?(Rails.root.join('app', 'assets', 'images', 'Jane_Smith.jpg'))
  user2.image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'Jane_Smith.jpg')),
    filename: 'Jane_Smith.jpg'
  )
else
  puts "Warning: Jane_Smith.jpg not found. Skipping image attachment for user2."
end

# 育成記録サンプル
cactus_diary = PlantDiary.find_or_create_by!(
  user: user1,
  title: "サボテンの成長記録",
  content: "サボテンの成長過程を記録しています。日光の当て方や水やりの頻度、土の乾き具合などをメモしています。"
)

if File.exist?(Rails.root.join('app', 'assets', 'images', 'cactus.jpg'))
  cactus_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cactus.jpg')), filename: 'cactus.jpg')
else
  puts "Warning: cactus.jpg not found. Skipping image attachment for cactus_diary."
end

ficus_diary = PlantDiary.find_or_create_by!(
  user: user1,
  title: "フィカス(ゴムの木)の日々の変化",
  content: "フィカスの葉の色や状態の変化を定期的に記録しています。光の当たり方や水やりのタイミングなども一緒にメモしています。"
)

if File.exist?(Rails.root.join('app', 'assets', 'images', 'ficus.jpg'))
  ficus_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'ficus.jpg')), filename: 'ficus.jpg')
else
  puts "Warning: ficus.jpg not found. Skipping image attachment for ficus_diary."
end

schefflera_diary = PlantDiary.find_or_create_by!(
  user: user2,
  title: "シェフレラの生育記録",
  content: "シェフレラの育成についての詳細なメモです。新しい葉が出るサイクルや土の交換時期などを記録しています。"
)

if File.exist?(Rails.root.join('app', 'assets', 'images', 'schefflera.jpg'))
  schefflera_diary.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'schefflera.jpg')), filename: 'schefflera.jpg')
else
  puts "Warning: schefflera.jpg not found. Skipping image attachment for schefflera_diary."
end

PlantDiary.find_or_create_by!(
  user: user1,
  title: "グリーンビーンの成長記録",
  content: "グリーンビーンの種を植えてからの成長過程を記録しています。初めての挑戦なのでどうなるかドキドキです！"
)

puts '初期データを追加しました。'
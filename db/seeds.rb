# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者
Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

# ユーザー
User.find_or_create_by!(email: "sample@example.com") do |user|
  user.password = 'password'
  user.name = 'John Doe'
  user.introduction = 'こんにちは、私はJohn Doeです。'
end

User.find_or_create_by!(email: "example@example.com") do |user|
  user.password = 'password'
  user.name = 'John K'
  user.introduction = 'こんにちは、私はJohn Kです。'
end

smith = User.find_or_create_by!(email: 'test@example.com') do |user|
  user.password = 'password'
  user.name = 'Jane Smith'
  user.introduction = 'はじめまして'
  user.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/Jane_Smith.jpg"), filename:"Jane_Smith.jpg")
end

brown = User.find_or_create_by!(email: 'brown@example.com') do |user|
  user.password = 'password'
  user.name = 'Michael Brown'
  user.introduction = 'こんにちは、よろしくお願いします！'
  user.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/Michael_Brown.jpg"),
    filename: 'Michael_Brown.jpg',
    content_type: 'image/jpeg'
  )
end

wilson = User.find_or_create_by!(email: 'wilson@example.com') do |user|
  user.password = 'password'
  user.name = 'Emily Wilson'
  user.introduction = 'Hi there, nice to meet you!'
  user.image.attach(
    io: File.open("#{Rails.root}/db/fixtures/Emily_Wilson.jpg"),
    filename: 'Emily_Wilson.jpg',
    content_type: 'image/jpeg'
  )
end

# 育成記録サンプル
cactus_diary = PlantDiary.find_or_create_by!(
  user_id: 1,
  title: "サボテンの成長記録",
  content: "サボテンの成長過程を記録しています。日光の当て方や水やりの頻度、土の乾き具合などをメモしています。"
)

cactus_diary.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/cactus.jpg"),
  filename: 'cactus.jpg',
  content_type: 'image/jpeg'
)

ficus_diary = PlantDiary.find_or_create_by!(
  user_id: 1,
  title: "フィカス(ゴムの木)の日々の変化",
  content: "フィカスの葉の色や状態の変化を定期的に記録しています。光の当たり方や水やりのタイミングなども一緒にメモしています。"
)

ficus_diary.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/ficus.jpg"),
  filename: 'ficus.jpg',
  content_type: 'image/jpeg'
)

green_bean_diary = PlantDiary.find_or_create_by!(
  user_id: 1,
  title: "グリーンビーンの成長記録",
  content: "グリーンビーンの種を植えてからの成長過程を記録しています。初めての挑戦なのでどうなるかドキドキです！"
)

schefflera_diary = PlantDiary.find_or_create_by!(
  user_id: 2,
  title: "シェフレラの生育記録",
  content: "シェフレラの育成についての詳細なメモです。新しい葉が出るサイクルや土の交換時期などを記録しています。"
)

schefflera_diary.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/schefflera.jpg"),
  filename: 'schefflera.jpg',
  content_type: 'image/jpeg'
)

rose_diary = PlantDiary.find_or_create_by!(
  user_id: 1,
  title: "バラの日々の変化",
  content: "バラの花の開花過程や健康状態の変化を記録しています。水やりの頻度や肥料の与え方などもメモしています。"
)

orchid_diary = PlantDiary.find_or_create_by!(
  user_id: 4,
  title: "オーキッドの育成記録",
  content: "オーキッドの成長過程や花の咲き方を記録しています。温度や湿度管理、水やりの方法なども詳細にメモしています。"
)

orchid_diary.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/orchid.jpg"),
  filename: 'orchid.jpg',
  content_type: 'image/jpeg'
)

mint_diary = PlantDiary.find_or_create_by!(
  user_id: 3,
  title: "ミントの栽培記録",
  content: "ミントの育て方や収穫の記録をしています。日光の当て方や土の水分管理など、ハーブ栽培のポイントをメモしています。"
)

mint_diary.image.attach(
  io: File.open("#{Rails.root}/db/fixtures/mint.jpg"),
  filename: 'mint.jpg',
  content_type: 'image/jpeg'
)

# 正しいユーザーが存在することを確認
user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.name = 'User1'
  user.introduction = 'こんにちは、User1です。'
  user.is_active = true
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.name = 'User2'
  user.introduction = 'はじめまして、User2です。'
  user.is_active = true
end

# 正しい所有者を持つコミュニティを作成
Community.find_or_create_by!(name: 'Community1', owner_id: user1.id) do |community|
  community.introduction = 'こちらはCommunity1です。'
  community.user_id = user1.id
end

Community.find_or_create_by!(name: 'Community2', owner_id: user2.id) do |community|
  community.introduction = 'Community2へようこそ！'
  community.user_id = user2.id
end


# リレーションシップの作成
# ユーザー1がユーザー2以外のユーザーをフォローする関係を追加
Relationship.find_or_create_by!(
  follower_id: 1,
  followed_id: 3
)

Relationship.find_or_create_by!(
  follower_id: 1,
  followed_id: 4
)

Relationship.find_or_create_by!(
  follower_id: 1,
  followed_id: 5
)

Relationship.find_or_create_by!(
  follower_id: 1,
  followed_id: 6
)

# ユーザー2がユーザー1以外のユーザーをフォローする関係を追加
Relationship.find_or_create_by!(
  follower_id: 2,
  followed_id: 3
)

Relationship.find_or_create_by!(
  follower_id: 2,
  followed_id: 4
)

Relationship.find_or_create_by!(
  follower_id: 2,
  followed_id: 5
)

Relationship.find_or_create_by!(
  follower_id: 2,
  followed_id: 6
)

# コメントの作成
Comment.find_or_create_by!(
  user_id: 1,
  plant_diary_id: 2
) do |comment|
  comment.content = '素晴らしいダイアリーエントリーです！'
end

Comment.find_or_create_by!(
  user_id: 1,
  plant_diary_id: 3
) do |comment|
  comment.content = '素晴らしいダイアリーエントリーです！'
end

Comment.find_or_create_by!(
  user_id: 2,
  plant_diary_id: 1
) do |comment|
  comment.content = 'これを読むのは楽しかったです。'
end

Comment.find_or_create_by!(
  user_id: 3,
  plant_diary_id: 1
) do |comment|
  comment.content = 'これを読むのは楽しかったです。'
end

# お気に入りの作成
Favorite.find_or_create_by!(
  user_id: 1,
  plant_diary_id: 2
)

Favorite.find_or_create_by!(
  user_id: 2,
  plant_diary_id: 1
)

puts '初期データを追加しました。'

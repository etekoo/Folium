# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Name.name[0..19] }  
    introduction { Faker::Lorem.sentence }
    is_active { true }
  end

  factory :guest_user, parent: :user do
    email { 'guest@example.com' }
    password { 'password' }
    name { 'Guest User' }
    introduction { 'This is a guest user.' }
    is_active { true }
  end
end

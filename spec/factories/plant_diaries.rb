# spec/factories/plant_diaries.rb
FactoryBot.define do
  factory :plant_diary do
    association :user
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
  end
end

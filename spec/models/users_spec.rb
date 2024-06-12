# spec/models/user_spec.rb
#binding.pry
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'バリデーションのテスト' do
    it '名前、メール、パスワードがあれば有効であること' do
      expect(user).to be_valid
    end

    it '名前がないと無効であること' do
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it '名前が2文字未満では無効であること' do
      user.name = 'A'
      user.valid?
      expect(user.errors[:name]).to include('is too short (minimum is 2 characters)')
    end

    it '名前が20文字を超えると無効であること' do
      user.name = 'A' * 21
      user.valid?
      expect(user.errors[:name]).to include('is too long (maximum is 20 characters)')
    end

    it '自己紹介が50文字を超えると無効であること' do
      user.introduction = 'A' * 51
      user.valid?
      expect(user.errors[:introduction]).to include('is too long (maximum is 50 characters)')
    end

    it 'メールが重複していると無効であること' do
      create(:user, email: user.email)
      user.valid?
      expect(user.errors[:email]).to include('has already been taken')
    end
  end

  describe 'メソッドのテスト' do
    it 'ゲストユーザーを作成できること' do
      guest = User.guest
      expect(guest).to be_persisted
      expect(guest.email).to eq(User::GUEST_USER_EMAIL)
      expect(guest.name).to eq('guestuser')
    end

    it '画像がリサイズされること' do
      user = create(:user)
      user.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      variant_with_record = user.resize_profile_image(100, 100, 'fit')
      expect(variant_with_record).to be_a(ActiveStorage::VariantWithRecord)
    end

    it '退会したユーザーがログインできないこと' do
      user.is_active = false
      expect(user.active_for_authentication?).to be_falsey
    end
  end
end

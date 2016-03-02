require 'rails_helper'

RSpec.describe User, type: :model do
  describe "db structure" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
    it { should have_db_index(:email) }
  end

  describe "associations" do
    it { should have_many(:authentication_tokens) }
  end

  describe "secure password" do
    it { should have_secure_password }
    it { should validate_length_of(:password) }

    it { expect(User.new(email: "user@gmail.com",password: nil).save).to be_falsey }
    it { expect(User.new(email: "user@gmail.com",password: "foo").save).to be_falsey }
    it { expect(User.new(email: "user@gmail.com",password: "foofoobar").save).to be_truthy }
  end
end

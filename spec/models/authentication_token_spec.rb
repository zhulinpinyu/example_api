require 'rails_helper'

RSpec.describe AuthenticationToken, type: :model do
  describe "db structure" do
    it{ should have_db_column(:user_id).of_type(:integer) }
    it{ should have_db_column(:body).of_type(:string) }
    it{ should have_db_column(:last_used_at).of_type(:datetime) }
    it{ should have_db_column(:ip_address).of_type(:string) }
    it{ should have_db_column(:user_agent).of_type(:string) }
    it{ should have_db_column(:created_at).of_type(:datetime) }
    it{ should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "associations" do
    it {should belong_to(:user)}
  end
end
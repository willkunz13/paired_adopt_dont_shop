require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    # it {should validate_presence_of :image}
    it {should validate_presence_of :title}
    it {should validate_presence_of :raiting}
    it {should validate_presence_of :content}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end
end

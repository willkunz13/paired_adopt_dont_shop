require 'rails_helper'

RSpec.describe Favorites do

  describe "total_count" do
    it "can calculate total number of pets it holds" do
      favorite1 = Favorites.new([1, 2])

      expect(favorite1.total_count).to eq(2)
    end
  end
end

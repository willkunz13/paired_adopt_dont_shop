require 'rails_helper'

RSpec.describe ApplicationPets, type: :model do
  describe "relationships" do
    it {should_belong to :application}
    it {should_belong to :pet}
  end
end

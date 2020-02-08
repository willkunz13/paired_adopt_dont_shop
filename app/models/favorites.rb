class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def total_count
    contents.size
  end
end

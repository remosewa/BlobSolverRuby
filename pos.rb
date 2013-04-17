class Pos
  attr_accessor  :row, :col
  def initialize(r,c)
    @row = r
    @col = c
  end

  def distance(opos)

    dist = Math.sqrt((@row - opos.row)**2 + (@col - opos.col)**2).to_i
    return dist
  end
end

class Move
  attr_accessor :from, :to, :score, :tempscore, :board, :othermoves, :team

  def initialize(from, to)
    @from = from
    @to = to
    @othermoves = []
    @level = 0
  end

  def distance
    return @from.distance(@to)
  end
  def getScore()
    otherScore = nil
    othermoves.each do |move|
      tscore = move.getScore()
      if (!otherScore)
        otherscore = tscore
      elsif (team == 0 && tscore < otherScore)
        otherScore = tscore
      elsif team != 0 && tscore > otherScore
        otherScore = tscore
      end
    end
    otherScore = 0 if otherScore == nil
    return @score + otherScore
  end

  def to_s
    "#{@to.col}#{@to.row}"
  end
end

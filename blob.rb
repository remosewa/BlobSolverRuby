class Blob
  attr_accessor :team, :pos

  def initialize(board, pos, team)
    @board = board
    @pos = pos
    @team = team
  end

  def getMoves()
     moves = []
    for r in (@pos.row - 2)..(@pos.row + 2)
      for c in (@pos.col - 2)..(@pos.col + 2)

          testp = Pos.new(r,c)
          testm = Move.new(@pos,testp)
          testm.team = @team
          moves.push testm if(r >= 0 && c >= 0 && r<8 && c < 8 && !@board.getSpot(testp))
      end
    end
      return moves
  end

  def copyBlob(board)
    return Blob.new(board,Pos.new(@pos.row,@pos.col),@team)
  end

end
class Board
  attr_accessor :matrix
  def initialize()
    @matrix = [[]]
    for r in 0..7
      @matrix[r] = []
      for c in 0..7
        @matrix[r][c] = nil

      end
    end
  end

  def addBlob(pos, team)
    @matrix[pos.row][pos.col] = Blob.new(self, pos, team)
  end

  def moveBlob(from, to)
    blob = getSpot(from)
    blob.pos = to
    @matrix[from.row][from.col] = nil
    @matrix[to.row][to.col] = blob
  end

  def getSpot(pos)
    return @matrix[pos.row][pos.col]
  end

  def makeMove(from, to, team)
    newboard = copyBoard()
    if (from.distance(to) <= 1)
      newboard.addBlob(to, team)
    else
      newboard.moveBlob(from, to)
    end
    for r in (to.row-1)..(to.row+1)
      for c in (to.col-1)..(to.col+1)
        newboard.getSpot(Pos.new(r, c)).team = team if (r >= 0 && c >= 0 && r< 8 && c < 8 &&  newboard.getSpot(Pos.new(r, c)))
      end
    end
    newboard
  end

  def getMyBlobs(team)
    bloblist = []
    for r in 0..7
      for c in 0..7
        blob = getSpot(Pos.new(r, c))
        bloblist.push blob if blob && blob.team == team
      end
    end
    return bloblist
  end

  def getScore(move,team)
    from = move.from
    to = move.to
    score = 0
    score = 1 if(from.distance(to) == 1)
    for r in (to.row-1)..(to.row+1)
      for c in (to.col-1)..(to.col+1)
         testblob = getSpot(Pos.new(r,c)) if(r >= 0 && c >= 0 && r< 8 && c < 8)
        score += 1 if( testblob && testblob.team != team)
      end
    end
    score = -score if team != 0
    score
  end

  def copyBoard()
    newboard = Board.new()
    for r in 0..7
      for c in 0..7
        newboard.matrix[r][c] = @matrix[r][c].copyBlob(newboard) if(@matrix[r][c] != nil)
      end
    end
    newboard
  end



end
class MoveExplorer
  attr_accessor :moves , :interrupt

  def initialize(board)
    @startboard = board
    @interrupt = false
    @queue = []
  end

  def start()
    @moves = []
    @moves = getMoves(@startboard, 0)
    while (@queue.size() > 0 && !@interrupt)
      obj = @queue.shift
      obj.move.othermoves = getMoves(obj.move.board, obj.team)
    end
  end

  def nextTeam(team)
    return 1 if team == 0
    return 0
  end

  def getMoves(board, team)
    moveMap = {}
     moves = []
    board.getMyBlobs(team).each do |blob|
      break if @interrupt
      #puts blob.getMoves.size
      blob.getMoves().each do |move|

        break if @interrupt
        #puts move.to_s if(moveMap.include?(move.to_s))
        if (move.distance != 1 || !moveMap.include?(move.to_s))
            moveMap[move.to_s] = true if move.distance == 1
          #puts "move = #{move.to_s}"
          move.score = board.getScore(move, team)
          newboard = board.makeMove(move.from, move.to, team)
          move.board = newboard
          move.team = team
          @queue.push ObjQueue.new(move, nextTeam(team))
          moves.push(move)
        end

      end
    end
    return moves
  end
end
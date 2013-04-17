RubyVM::InstructionSequence.compile_option = {
    :tailcall_optimization => true,
    :trace_instruction => false
}


require_relative 'board'
 require_relative 'pos'
 require_relative 'move'
 require_relative 'blob'
 require_relative 'move_explorer'
 require_relative 'obj_queue'


class BlobSolver
  def initialize(move_first)
    board = newBoard(move_first)
    input = nil
    input = gets if !move_first
    while (move_first || input != "exit")
      if (!move_first)
        nlist = input.split(',')
        posf = Pos.new(nlist[0].to_i, nlist[1].to_i)
        post = Pos.new(nlist[2].to_i, nlist[3].to_i)
        board = board.makeMove(posf, post, 1)
        #draw_board(board)
      else
        move_first = false
      end
      me = MoveExplorer.new(board)
      t = Thread.new do
        me.start
      end
      sleep 0.5
      me.interrupt = true
      t.join
      bm = bestMove(me.moves)
      board = board.makeMove(bm.from, bm.to, 0)
      #draw_board(board)
      puts "#{bm.from.row},#{bm.from.col},#{bm.to.row},#{bm.to.col}"
      STDOUT.flush
      input = gets
    end
  end

  def newBoard(move_first)
    board = Board.new()
    if(move_first)
    board.addBlob(Pos.new(0, 0), 0)
    board.addBlob(Pos.new(0, 7), 0)
    board.addBlob(Pos.new(7, 0), 1)
    board.addBlob(Pos.new(7, 7), 1)
    else
      board.addBlob(Pos.new(0, 0), 1)
      board.addBlob(Pos.new(0, 7), 1)
      board.addBlob(Pos.new(7, 0), 0)
      board.addBlob(Pos.new(7, 7), 0)
      end
    board
  end

  def draw_board(board)
    for r in  0..7
      st = ""
      for c in  0..7
        blob = board.getSpot(Pos.new(r,c))
        if(!blob)
        st += "# "
        elsif (blob.team == 0)
        st += "0 "
        else
        st += "1 " if(blob.team == 1)
          end

      end
      puts st

    end
    puts "----------------"
  end

  def bestMove(moves)
    bestScore = nil
    bestmove = nil
    moves.each do |move|
      score = move.getScore()
      if (!bestScore || score > bestScore)
        bestScore = score
        bestmove = move
      end
    end
    return bestmove
  end
end
 # puts "hello world"
begin
BlobSolver.new(false)
rescue
  puts $!
  STDOUT.flush

  end

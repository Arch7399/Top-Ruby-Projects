require 'set'

def makeGrid(size)
  chessboard = []
  size.times do |row|
    chessboard[row] = []
    size.times do |col|
      chessboard[row].push([row,col])
    end
  end
  return chessboard
end

def func1(board, start, tgt)
  visited = Set.new()
  visited.add(start)
  queue = [[start]]
  path = {}
  while queue.length > 0
    curr_path = queue.shift()
    curr_pos = curr_path.last
    if curr_pos == tgt
      return reconstruct_path(curr_path, path)
    end
    neighbours = [      [curr_pos[0]-2, curr_pos[1]-1], [curr_pos[0]-2, curr_pos[1]+1],
      [curr_pos[0]-1, curr_pos[1]+2], [curr_pos[0]+1, curr_pos[1]+2],
      [curr_pos[0]+2, curr_pos[1]+1], [curr_pos[0]+2, curr_pos[1]-1],
      [curr_pos[0]+1, curr_pos[1]-2], [curr_pos[0]-1, curr_pos[1]-2]
    ]
    neighbours.each do |moves|
      x, y = moves
      boundX = 0 <= x && x < board.length
      boundY = 0 <= y && y < board[0].length
      if boundX && boundY && !visited.include?(moves)
        visited.add(moves)
        path[moves] = curr_pos
        queue.push(curr_path + [moves])
      end
    end
  end
  return "No path found"
end

def reconstruct_path(curr_path, path)
  shortest_path = []
  curr_pos = curr_path.last
  while curr_pos
    shortest_path.unshift(curr_pos)
    curr_pos = path[curr_pos]
  end
  return shortest_path
end

p makeGrid(8)
p func1(makeGrid(8), [0,3], [7,7])

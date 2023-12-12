input = File.read('inputs/day10').split("\n")

grid = input.map(&:chars)
row = grid.each_index.select{ |i| grid[i].any? { |j| j == 'S' }}.first
col = grid[row].each_index.select{ |i| grid[row][i] == 'S' }.first

if '7J-'.chars.include? grid[row][col + 1]
  direction = :e
elsif 'LJ|'.chars.include? grid[row + 1][col]
  direction = :s
elsif 'LF-'.chars.include? grid[row][col - 1]
  direction = :w
elsif '7F|'.chars.include? grid[row - 1][col]
  direction = :n
end
$left_turns = 0
$right_turns = 0
def next_direction(d, c)
  if (([:n, :s].include? d) && (c == '|')) || (([:e, :w].include? d) && (c == '-'))
    d
  elsif (d == :n && c == '7') || (d == :s && c == 'J')
    d == :n ? $left_turns += 1 : $right_turns += 1
    :w
  elsif (d == :n && c == 'F') || (d == :s && c == 'L')
    d == :n ? $right_turns += 1 : $left_turns += 1
    :e
  elsif (d == :e && c == 'J') || (d == :w && c == 'L')
    d == :e ? $left_turns += 1 : $right_turns += 1
    :n
  elsif (d == :e && c == '7') || (d == :w && c == 'F')
    d == :e ? $right_turns += 1 : $left_turns += 1
    :s
  end
end


def symbol_in_dir(row, col, dir, grid)
  if dir == :n
    grid[row - 1][col]
  elsif dir == :s
    grid[row + 1][col]
  elsif dir == :e
    grid[row][col + 1]
  elsif dir == :w
    grid[row][col - 1]
  end
end
def left(row, col, dir)
  if dir == :n
    [row, col - 1]
  elsif dir == :s
    [row, col + 1]
  elsif dir == :e
    [row - 1, col]
  elsif dir == :w
    [row + 1, col]
  end
end

def right(row, col, dir)
  if dir == :n
    [row, col + 1]
  elsif dir == :s
    [row, col - 1]
  elsif dir == :e
    [row + 1, col]
  elsif dir == :w
    [row - 1, col]
  end
end

steps = 0
symbol = symbol_in_dir(row, col, direction, grid)
visited = [[row, col]]
lefts = [left(row, col, direction)]
rights = [right(row, col, direction)]
while true do
  steps += 1
  if direction == :n
    row += -1
  elsif direction == :s
    row += 1
  elsif direction == :w
    col += -1
  elsif direction == :e
    col += 1
  end
  lefts << left(row, col, direction)
  rights << right(row, col, direction)
  direction = next_direction(direction, symbol)
  symbol = symbol_in_dir(row, col, direction, grid)
  visited << [row, col]
  lefts << left(row, col, direction)
  rights << right(row, col, direction)
  break if symbol == 'S'
end

puts visited.size / 2

def expand(grid, start, visited)
  area = start.reject{ |k| visited.include? k }.
    select{ |row, col| (row.between? 0, grid.size - 1) and (col.between? 0, grid[0].size - 1) }.
    uniq
  to_check = area
  while true do
    potential_area = []
    to_check.each do |row, col|
      potential_area << [row + 1, col]
      potential_area << [row - 1, col]
      potential_area << [row, col + 1]
      potential_area << [row, col - 1]
    end
    potential_area = potential_area.reject{ |k| (visited.include? k) or (area.include? k) }.
      select{ |row, col| (row.between? 0, grid.size - 1) and (col.between? 0, grid[0].size - 1) }.uniq
    break if potential_area.size == 0
    to_check = potential_area
    area = area + potential_area
  end
  area.uniq
end
lefts = expand(grid, lefts, visited)
rights = expand(grid, rights, visited)

puts $left_turns > $right_turns ? lefts.size : rights.size

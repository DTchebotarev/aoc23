input = File.read('inputs/day03').split("\n")
  .map{|l| '..' + l + '..'}

input.prepend('.' * input[0].length)
input.append('.' * input[0].length)

input.each_cons(3).map do |prev_line, line, next_line|
  line.to_enum(:scan,/\d+/).map{ [$~.begin(0)-1, $~.end(0), $~.to_s] }.map do |o|
    [prev_line, line, next_line].map { |l| l[o[0]..o[1]] }.join =~ /[^\d\.]/ ? o[2].to_i : 0
  end.sum
end.sum.then{|m| puts m}

ranges = input.map do |line|
  line.to_enum(:scan,/\d+/).map{ [$~.begin(0), $~.end(0)-1, $~.to_s.to_i] }
end
def part_of_number(row, col, ranges)
  match = ranges[row].filter{|c| col.between?(c[0],c[1])}
  match.first unless match.empty?
end

def check_all_directions (row, col, ranges)
  [ part_of_number(row, col-1, ranges), # west
    part_of_number(row-1, col-1, ranges), # northwest
    part_of_number(row-1, col, ranges), # north
    part_of_number(row-1, col+1, ranges), # northeast
    part_of_number(row, col+1, ranges), # east
    part_of_number(row+1, col+1, ranges), # southeast
    part_of_number(row+1, col, ranges), # south
    part_of_number(row+1, col-1, ranges), # southwest
  ].compact
end

ranges_to_sum = Set.new
(1..input.length-2).each do |row|
  (1..input[0].length-2).each do |col|
    check_all_directions(row, col, ranges).map{ |r| ranges_to_sum.add(r) } if input[row][col] =~ /[^\d\.]/
  end
end

puts ranges_to_sum.map{|v| v[2]}.sum

gearsum = 0
(1..input.length-2).each do |row|
  (1..input[0].length-2).each do |col|
    gear_nums = input[row][col] =~ /\*/ ? check_all_directions(row, col, ranges).uniq : []
    gearsum += gear_nums.map{|k| k[2]}.reduce(:*) if gear_nums.size >= 2
  end
end
puts gearsum

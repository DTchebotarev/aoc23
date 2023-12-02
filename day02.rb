input = File.read('inputs/day02').split("\n")

games = input.each_with_index.map do |line, number|
  [number+1, ['r','g','b'].map{|k| line.scan(/(\d+) #{k}/).flatten.map(&:to_i).max}]
end.to_h

puts games.select{|_, g| g[0] <= 12 && g[1] <= 13 && g[2] <= 14}.keys.sum
puts games.values.map{|i| i.reduce(&:*)}.sum

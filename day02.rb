input = File.read('inputs/day02').split("\n")

games = input.each_with_index.map do |line, number|
  [number+1, ['r','g','b'].map{|k| line.scan(/(\d+) #{k}/).flatten.map(&:to_i).max}]
end.to_h

games.select do |game_num, game|
  game[0] <= 12 && game[1] <= 13 && game [2] <= 14
end.keys.sum.then { |s| puts s }

puts games.values.map{|i| i.reduce(&:*)}.sum

input = File.read('inputs/day04').split("\n")

input.map do |line|
  (winning, card) = line.split(':')[1].split('|').map{ |l| l.scan(/\d+/).map(&:to_i) }
  winners = card.filter{|c| winning.include? c}
  winners.size > 0 ? 2**(winners.size - 1) : 0
end.sum.then{|l| puts l}

cards = [1] * input.length

input.each_with_index do |line, game_num|
  (winning, card) = line.split(':')[1].split('|').map{ |l| l.scan(/\d+/).map(&:to_i) }
  card.filter{|c| winning.include? c}.each_with_index do |_, i|
    cards[game_num + i + 1] += cards[game_num]
  end
end

puts cards.sum

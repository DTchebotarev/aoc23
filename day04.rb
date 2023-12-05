input = File.read('inputs/day04').split("\n")

cards = [1] * input.length
input.map.with_index do |line, game_num|
  (winning, card) = line.split(':')[1].split('|').map{ |l| l.scan(/\d+/).map(&:to_i) }
  winners = card.filter{|c| winning.include? c}
  winners.each_with_index do |_, i|
    cards[game_num + i + 1] += cards[game_num]
  end
  winners.size > 0 ? 2**(winners.size - 1) : 0
end.sum.then{|l| puts l}
puts cards.sum

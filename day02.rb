input = File.read('inputs/day02').split("\n")

$games = {}

input.each do |line|
  game_number = line.split(': ').first.scan(/\d+/)[0].to_i
  sets = line.split(': ').last.split('; ')
  games_list = []
  sets.each do |set|
    game = {
    red: set.scan(/(\d+) red/).flatten[0].to_i,
    blue: set.scan(/(\d+) blue/).flatten[0].to_i,
    green: set.scan(/(\d+) green/).flatten[0].to_i,
  }
  games_list.append(game)
  end
  $games[game_number] = games_list
end

def is_legal(game)
  return game[:red] <= 12 && game[:green] <= 13 && game[:blue] <= 14
end

games_sum = 0
games_power_sum = 0

$games.each do |game_num, game_list|
  games_sum += game_num if game_list.map{|g| is_legal g}.all?
end

$games.each do |game_num, game_list|
  red = game_list.map{|g| g[:red]}.select{|a| a > 0}.max
  blue = game_list.map{|g| g[:blue]}.select{|a| a > 0}.max
  green = game_list.map{|g| g[:green]}.select{|a| a > 0}.max
  games_power_sum += red*blue*green
end

puts games_sum
puts games_power_sum

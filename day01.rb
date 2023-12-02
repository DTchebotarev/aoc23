input = File.read('inputs/day01')

$numberHash = {
  'one'   => '1',
  'two'   => '2',
  'three' => '3',
  'four'  => '4',
  'five'  => '5',
  'six'   => '6',
  'seven' => '7',
  'eight' => '8',
  'nine'  => '9'
}

$regex = Regexp.new('(?=(\d|'+$numberHash.keys.join('|')+'))')

puts input
  .split
  .map{|l| l.scan(/\d/).then{|n| (n.first + n.last)}.to_i}
  .sum
puts input
  .split
  .map{|l| l.scan($regex).flatten.map{|d| d =~ /\d/ ? d : $numberHash[d]}.then{|n| (n.first + n.last).to_i}}
  .sum

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

def getNumbersFromLine(line)
  numbers = line.scan(/\d/)
  return (numbers.first + numbers.last).to_i
end

def getNumbersFromLine2(line)
  regex = Regexp.new('(?=(\d|'+$numberHash.keys.join('|')+'))')
  numbers = line.scan(regex).flatten.map{|d| d =~ /\d/ ? d : $numberHash[d]}
  return (numbers.first + numbers.last).to_i
end

puts input.split.map{|l| getNumbersFromLine l}.sum
puts input.split.map{|l| getNumbersFromLine2 l}.sum

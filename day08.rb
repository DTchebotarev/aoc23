input = File.read('inputs/day08')

(instructions, maps) = input.split("\n\n")
maps = maps.split("\n").map{ |l| l.scan(/\w+/) }

steps_array = []
maps.filter{ |m| m[0].chars[2] == 'A' }.map{ |m| m[0] }.sort.each do |step|
  current_step = step
  steps = 0
  instructions.chars.cycle.each do |i|
    steps += 1  
    current_map = maps.filter{ |m| m[0] == current_step }.first
    current_step = i == 'L' ? current_map[1] : current_map [2]
    break if current_step.chars[2] == 'Z'
  end
  steps_array.append(steps)
end

def primes(n)
  divisors = {}
  d = 2
  while n >= d 
    if n % d == 0
      divisors[d] = divisors.fetch(d,0) + 1
      n = n/d
    else
      d += 1
    end
  end
  divisors
end

puts steps_array[0] # pt 1, because we sorted 'AAA' is first
prime_components = steps_array.map{ |s| primes(s) }
puts prime_components.map{ |p| p.keys }.flatten.uniq.reduce(&:*).to_s # not general solution, but no prime powers were above 1
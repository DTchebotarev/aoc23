input = File.read('inputs/day06').split("\n")

(times, distances) = input.map{ |l| l.scan(/\d+/) }
races = times.zip(distances)

def quad(a,b,c)
  [(-b + (b**2 - 4 * a * c)**0.5)/(2 * a), (-b - (b**2 - 4 * a * c)**0.5)/(2 * a)]
end

puts races.map{ |r| quad(-1, r[0].to_i, -1 * r[1].to_i) }.map{ |l| l[1].to_i - l[0].to_i }.reduce(&:*)
puts quad(-1, times.reduce(&:+).to_i, -1 * distances.reduce(&:+).to_i).then{ |l| l[1].to_i - l[0].to_i }

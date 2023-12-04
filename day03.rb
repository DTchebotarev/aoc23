input = File.read('inputs/day03').split("\n")
  .map{|l| '..' + l + '..'}

input.prepend('.' * input[0].length)
input.append('.' * input[0].length)

input.each_cons(3).map do |prev_line, line, next_line|
  line.to_enum(:scan,/\d+/).map{ [$~.begin(0)-1, $~.end(0), $~.to_s] }.map do |o|
    [prev_line, line, next_line].map { |l| l[o[0]..o[1]] }.join =~ /[^\d\.]/ ? o[2].to_i : 0
  end.sum
end.sum.then{|m| puts m}

input_raw = File.read('inputs/day11').split("\n").map(&:chars)

def get_num_galaxies(input, gravity)
  input = input.map{ |l| l.uniq == ['.'] ? [l.join]*gravity : l.join }.flatten.map(&:chars)
  input = input.transpose.map{ |l| l.uniq == ['.'] ? [l.join]*gravity : l.join }.flatten.map(&:chars)
  input = input.each_with_index.map do |r, rn|
    r.each_with_index.map do |c, cn|
      c == '#' ? "r#{rn}c#{cn}" : c
    end
  end

  input = input.flatten.select{ |e| e =~ (/^r/) }

  distances = 0
  input.each do |outer|
    input.each do |inner|
      distances += (inner.scan(/r(\d+)/).flatten.first.to_i - outer.scan(/r(\d+)/).flatten.first.to_i).abs
      distances += (inner.scan(/c(\d+)/).flatten.first.to_i - outer.scan(/c(\d+)/).flatten.first.to_i).abs
    end
  end

  distances/2
end

puts get_num_galaxies(input_raw, 2)
# linear interpolation
puts (get_num_galaxies(input_raw, 3) - get_num_galaxies(input_raw,2)) * (1000000 - 2) + get_num_galaxies(input_raw,2)

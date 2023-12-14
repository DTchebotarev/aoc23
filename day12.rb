input = File.read('inputs/day12e').split("\n")

def validate(combined, start = 0, original_broken = nil, call_depth = 0)
  puts combined if call_depth == 0
  (springs, nums) = combined.split
  broken = nums.split(',').map(&:to_i)
  original_broken = broken unless original_broken
  num_to_place = broken[0]
  valid = ([0, start].max..springs.size - num_to_place).map do |i|
    [i, springs[0,i] + (['#'] * num_to_place).join + (springs[i + num_to_place..-1] or '')]
  end.filter do |s|
    s[1].chars.zip(springs.chars).map{ |r, s| s == '?' or s == r}.all?
  end.filter do |s|
    s[1].include? '?' or s[1].scan(/#+/).map(&:size) == original_broken
  end.uniq
  f = 1 + 2
  # puts valid.to_s unless broken.size > 1
  return valid.map{ |k| k[1].gsub '?', '.' }.to_a unless broken.size > 1
  valid.map do |k|
    next_level = k[1] + ' ' + broken[1..-1].join(',')
    # puts combined + '||' + next_level + '||' + valid.to_s + '||' + call_depth.to_s
    validate(next_level, k[0], original_broken, call_depth + 1)
  end.flatten.filter do |s|
    s.scan(/#+/).map(&:size) == broken or call_depth > 0
  end.uniq
end
puts input.map{ |k| validate(k) }.map(&:size).reduce(&:+)

# puts input.map{ |i| valid_num(i) }.to_s

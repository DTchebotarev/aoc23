input = File.read('inputs/day05')

maps = input.scan(/([^\d]+:\n[\d|\s]+)/).flatten.map do |m|
  m.split("\n").map do |l|
    l.scan(/\d+/).map(&:to_i)
  end.filter(&:any?)
end

current_value = maps.shift.first
start_ranges = current_value.each_slice(2).to_a

maps.each do |m|
  (0..current_value.length-1).each do |i|
    m.each do |entry|
      if current_value[i].between?(entry[1], entry[1] + entry[2] - 1)
        current_value[i] = current_value[i] - entry[1] + entry[0]
        break
      end
    end
  end
end

puts 'part 1', current_value.min.to_s

maps.each do |m|
  next_ranges = []
  while start_ranges.any?
    range = start_ranges.shift
    match = false
    m.each do |entry|
      (range_start, range_length) = range
      range_end = range_start + range_length
      (source_start, source_length) = [entry[1], entry[2]]
      source_end = source_start + source_length
      (dest_start, dest_length) = [entry[0], entry[2]]
      dest_end = dest_start + dest_length
      new_start = [range_start, source_start].max + dest_start - source_start
      new_end = [range_end, source_end].min + dest_start - source_start
      new_length = new_end - new_start - 1
      if new_length > 0
        next_ranges.push [new_start, new_length]
        start_ranges.push [range_start, source_start - range_start] if source_start > range_start
        start_ranges.push [source_end, range_end - source_end] if source_end < range_end
        match = true
        break
      end
    end
    next_ranges.push range if not match
  end
  start_ranges = next_ranges + start_ranges
end

puts "part 2", start_ranges.map{ |l| l[0] }.min

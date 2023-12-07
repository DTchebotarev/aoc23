input = File.read('inputs/day07').split("\n")

card_vals = {
  'T' => 10,
  'J' => 11,
  'Q' => 12,
  'K' => 13,
  'A' => 14
}

input.sort_by do |l|
  chars = l.split[0].chars
  vals = chars
          .uniq
          .map{ |a| chars.count(a) }
          .sort
          .reverse
  ([0]*5).zip(vals).map{ |a| a[0] + a[1].to_i } +
    chars.map{ |a| card_vals[a] || a.to_i }
end.each_with_index.map do |l, i|
  l.split[1].to_i * (i+1)
end.sum.then{ |a| puts a.to_s}

card_vals = {
  'T' => 10,
  'J' => 1,
  'Q' => 12,
  'K' => 13,
  'A' => 14
}

input.sort_by do |l|
  chars = l.split[0].chars
  val_counts = chars
          .uniq
          .map{ |a| chars.count(a) unless a == 'J' }
          .compact
  if val_counts.any?
    vals = val_counts
          .sort
          .reverse
    vals[0] += chars.count('J')
  else
    vals = [5]
  end
  ([0]*5).zip(vals).map{ |a| a[0] + a[1].to_i } +
    chars.map{ |a| card_vals[a] || a.to_i }
end.each_with_index.map do |l, i|
  l.split[1].to_i * (i+1)
end.sum.then{ |a| puts a.to_s}

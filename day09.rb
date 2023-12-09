input = File.read('inputs/day09').split("\n")

def derivative(arr)
  arr[1..-1].zip(arr[0..-2]).map{ |a, b| a - b }
end

def predict(arr)
  arr.uniq == [0] ? arr << 0 : arr << arr[-1] + predict(derivative(arr))[-1]
end

p input.map{ |i| i.split(' ').map(&:to_i).then(&method(:predict))[-1] }.sum
p input.map{ |i| i.split(' ').reverse.map(&:to_i).then(&method(:predict))[-1] }.sum

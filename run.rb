require 'benchmark'
require_relative 'tree'

def generate_random_data(size)
  Array.new(size) { rand(1..1000) }
end

def measure_complexity(tree, dataset)
  insert_time = Benchmark.realtime do
    dataset.each { |key| tree.insert(key) }
  end

  find_time = Benchmark.realtime do
    dataset.each { |key| tree.find(key) }
  end

  delete_time = Benchmark.realtime do
    dataset.each { |key| tree.delete(key) }
  end

  { insert_time: insert_time, find_time: find_time, delete_time: delete_time }
end

# Generate 100 random datasets
datasets = Array.new(100) { generate_random_data(100) }

# Measure complexity for each dataset
results = datasets.map do |dataset|
  tree = AVLTree.new
  measure_complexity(tree, dataset)
end

# Calculate average times
average_times = results.reduce({ insert_time: 0, find_time: 0, delete_time: 0 }) do |sums, result|
  sums[:insert_time] += result[:insert_time]
  sums[:find_time] += result[:find_time]
  sums[:delete_time] += result[:delete_time]
  sums
end

average_times.each { |key, value| average_times[key] = value / datasets.size }

puts "Average Insert Time: #{average_times[:insert_time]} seconds"
puts "Average Find Time: #{average_times[:find_time]} seconds"
puts "Average Delete Time: #{average_times[:delete_time]} seconds"

def counting_sort(arr)
  return arr if arr.empty?

  max_value = arr.max
  min_value = arr.min
  range = max_value - min_value + 1

  # Initialize count array
  count = Array.new(range, 0)

  # Store the count of each element
  arr.each do |num|
    count[num - min_value] += 1
  end

  # Build the output array
  sorted_arr = []
  count.each_with_index do |num, index|
    num.times { sorted_arr << index + min_value }
  end

  sorted_arr
end

# Example usage
arr = [4, 2, 2, 8, 3, 3, 1]
sorted_arr = counting_sort(arr)
puts "Sorted array: #{sorted_arr}"



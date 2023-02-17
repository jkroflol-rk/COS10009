
require 'benchmark'

# Code for bubble sort
NUM_ITEM = 10000
# Max VALUE of 100%
MAX_VALUE = 100
num_compare = 0
arr = Array.new(NUM_ITEM)

# Randomly put some final exam VALUEs into arr

for i in (0..NUM_ITEM - 1)
  arr[i] = rand(MAX_VALUE + 1)
end


# Now let's use bubble sort. Swap pairs iteratively as we loop through the
# array from the beginning of the array to the second-to-last value

puts Benchmark.measure {
for i in (0..NUM_ITEM - 2)
  # From arr[i + 1] to the end of the array
  for j in ((i + 1)..NUM_ITEM - 1)
    num_compare = num_compare + 1
    # If the first value is greater than the second value, swap them
    if (arr[i] > arr[j])
      temp = arr[j]
      arr[j] = arr[i]
      arr[i] = temp
    end
  end
end
}


puts "Number of Comparisons ==> " + num_compare.to_s

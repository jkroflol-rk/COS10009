require './input_functions'

# Complete the code below
# Use input_functions to read the data from the user

class Race 
    attr_accessor :des ,:id ,:time, :location 
    def initialize(des, id, time, location)
        @des = des
        @id = id
        @time = time
        @location = location
    end 
end 

def read_a_race()
	des = read_string("Enter race description:")
    id = read_integer("Enter id:")
    time = read_string("Enter time:")
    location = read_string("Enter location:")
    race = Race.new(des, id, time, location)
end

def read_races()
	count = read_integer("How many races are you entering:")
    races = Array.new
    while count > 0 
        races << read_a_race()
        count -= 1
    end
    return races
end

def print_a_race(race)
	puts("Race description " + race.des)
    puts("Id " + race.id.to_s)
    puts("Time " + race.time)
    puts("Location " + race.location)
end

def print_races(races)
	races.each { |race| print_a_race(race) }
end

def main()
	races = read_races()
	print_races(races)
end

main()
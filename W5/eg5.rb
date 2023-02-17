class Student_record 
	attr_accessor :name, :age
	def initialize(name, age)
		@name = name 
		@age = age 
	end 
end 

student_records = Array.new()
student_record1 = Student_record.new("Vinh",20)
student_records << student_record1
student_record2 = Student_record.new("Hoa",40)
student_records << student_record2

=begin
puts(student_record2)
puts(student_record2.name)
puts(student_record2.age)

puts(student_records[0])
puts(student_records[0].name)
puts(student_records[0].age)

puts(student_records)
=end

def print_record(record) #print a student record
	puts("Name = " + record.name) 
	puts("and age = " + record.age.to_s)
end 

def print_records(student_records) #print many student records (as a table)
	index = 0 
	while (index < student_records.length)
		print_record(student_records[index])
		index += 1 
	end 
end 

print_records(student_records)

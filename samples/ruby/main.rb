# frozen_string_literal: true

# A person who can greet.
class Person
  attr_reader :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def greet
    "Hello, #{name}! You are #{age}."
  end
end

def total(numbers)
  numbers.sum
end

people = [Person.new('world', 30), Person.new('Neovim', 10)]

people.each { |person| puts person.greet }

puts "sum: #{total([1, 2, 3])}"

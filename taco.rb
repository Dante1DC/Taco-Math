#!/usr/bin/env ruby

# taco.rb
class Sticker
  attr_reader :taco_value, :name

  def initialize(name, taco_value)
    @name = name
    @taco_value = taco_value
  end

  def +(other)
    case other
    when Sticker
      @taco_value + other.taco_value
    when Integer
      @taco_value + other
    else
      raise "Unsupported 🌮"
    end
  end

  def *(scalar)
    @taco_value * scalar
  end

  def to_s
    "#{@name}: #{@taco_value} 🌮"
  end

  def self.days(starting_tacos, num_days)
    starting_tacos + (num_days * 5)
  end
end

def calculator
  stickers = {}
  ans = 0

  stickers["taco_box"] = Sticker.new("Taco Box", 3)
  stickers["super_taco"] = Sticker.new("Super Taco", 2)
  stickers["taco_trophy"] = Sticker.new("Taco Trophy", 5)
  stickers["ghost_sauce"] = Sticker.new("Ghost Sauce", 20)
  stickers["jalapeno_sauce"] = Sticker.new("Jalapeno Sauce", 10)

  puts "\n🌮"
  puts "Type expressions like 'taco_box * 3', 'super_taco + taco_box', or 'days(starting_tacos, days)'."
  puts "Use 'ans' to refer to the most recent result."
  puts "Type 'exit' to quit.\n\n"

  loop do
    print "> "
    input = gets.chomp.strip

    break if input.downcase == "exit"

    input.gsub!("ans", ans.to_s)

    stickers.each do |name, sticker|
      input.gsub!(name, sticker.taco_value.to_s)
    end

    if input =~ /^days\((\d+),\s*(\d+)\)$/
      starting_tacos = $1.to_i
      num_days = $2.to_i
      ans = Sticker.days(starting_tacos, num_days)
      puts "Total tacos after #{num_days} days: #{ans} 🌮"
    else
      begin
        ans = eval(input)
        puts "#{ans} 🌮"
      rescue StandardError => e
        puts "Error: #{e.message}"
      end
    end
  end

  puts "Exiting 🌮"
end

calculator

class RPN
  attr_accessor :memory
  def initialize
    @memory = []
  end

  def run
    if !ARGV[0]
      puts "please enter an operation"
      commands = gets.chomp
    else
      commands = File.readlines(ARGV[0]).first.chomp
    end
    evaluate(commands)
    p memory
  end

  def evaluate string
    operands = string.split

    operands.each do |value|
      case value
      when /\d/
        memory << value.to_f
      when "+"
        add
      when "-"
        subtract
      when "/"
        divide
      when "*"
        multiply
      end
    end
  end

  def add
    memory << memory.pop + memory.pop
  end

  def subtract
    temp = memory.pop
    memory << memory.pop - temp
  end

  def multiply
    memory << memory.pop * memory.pop
  end

  def divide
    temp = memory.pop
    memory << memory.pop / temp
  end

end

cal = RPN.new.run

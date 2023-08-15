# Пример простой программы на Ruby
class HelloWorld
  def initialize(name)
    @name = name.capitalize
  end

  def say_hello
    puts "Привет, #{@name}!"
  end
end

# Создание объекта класса HelloWorld и вызов метода say_hello
hello = HelloWorld.new("Мир")
hello.say_hello

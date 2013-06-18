=begin
Object Oriented Programming
Agenda
Part 1
- OOP in Ruby
- classes and objects
- instance methods
-instance variables
-getters / setters - look up and check its syntax and .self
-using objects

Part 2
-class methods - look up
-class variables - look up
-domain modelling
 -inheritance
 -composition

part 3
=end

#In methods and classes always return your strings and use puts outside it when calling them
#In order to build a OOP start by::
#Extracting major NOUNS into classes
#Identify behaviours of those nouns, and extract as methods
#Inheritance v composition
# - 'is a' relationship uses a inheritance
# - 'has a' relationship uses a composition

class Dog
 #create getters and setters with this shortcut
 attr_accesor :name, :weight, :height
 #Classes
 #State/attributes/instance variables
 #behaviours/methods/instance methods

 def initialize(n,w,h)
 	@name = n
 	@weight = w
 	@height = h
 end

 def speak
 	"#{name}: bark"
 end

end

fido = Dog.new('fido',12,1.3)

puts fido.speak



#is a relationship => Inheritance
#has a relationship => Composition use modules





















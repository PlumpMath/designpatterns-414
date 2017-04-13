# Imagine we have some code where we want to accomplish things in a variety of ways. One way to do this is with conditional branching:

class Animal
  def speak(kind)
    puts case kind
    when :dog then "woof!"
    when :cat then "meow!"
    when :owl then "hoo!"
    end
  end
end

Animal.new.speak(:dog)
# This works, but what if a developer wants to add a new way? With conditional branching, the entire method would need to be overwritten. Instead, we can separate the implementations into modules:

class Animal
  module Adapter
    module Dog
      def self.speak
        puts "woof!"
      end
    end

    module Cat
      def self.speak
        puts "meow!"
      end
    end
  end

  def speak
    self.adapter.speak
  end

  def adapter
    return @adapter if @adapter
    self.adapter = :dog
    @adapter
  end

  def adapter=(adapter)
    @adapter = Animal::Adapter.const_get(adapter.to_s.capitalize)
  end
end

animal = Animal.new
animal.speak
animal.adapter = :cat
aanimal.speak
# This is a lot more code! However, if we want to add another module, it’s not too bad and a lot more flexible:

class Animal
  module Adapter
    module Owl
      def self.speak
        puts "hoo!"
      end
    end
  end
end

animal.adapter = :owl
animal.speak
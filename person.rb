# Person class
class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end
  attr_reader :id
  attr_accessor :name, :age

  def can_use_services?
    return true if of_age? || @parent_permission == true

    false
  end

  private

  def of_age?
    return true if age >= 18

    false
  end
end

pes = Person.new(10, 'apple', parent_permission: true)

p pes.can_use_services?

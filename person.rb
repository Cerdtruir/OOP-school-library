require_relative('corrector')

# Person class
class Person
  def initialize(age:, name: 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def can_use_services?
    return true if of_age? || @parent_permission

    false
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def rental(book, date)
    Rental.new(self, book, date)
  end

  private

  def of_age?
    return true if @age >= 18
  end
end

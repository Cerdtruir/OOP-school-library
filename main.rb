require_relative 'book'
require_relative 'teacher'
require_relative 'student'
require_relative 'rental'

class SchoolLibrary
  attr_accessor :books, :people

  def initialize
    @books = []
    @people = []
  end

  def main
    puts 'Welcome to the School Library App'
    puts 'Please choose an option by entering one of the following numbers:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Add a person'
    puts '4 - Add a book'
    puts '5 - Add a rental'
    puts '6 - List books rented by a person'
    puts '7 - Exit'
    selection = gets.chomp
    puts ''
    select_menu(selection)
  end

end

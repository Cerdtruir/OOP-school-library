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

  private

  def select_menu(selection)
    case selection
    when '1'
      books.each { |book| puts "#{book.title} #{book.author}" }
    when '2'
      people.each { |person| puts person.name }
    when '3'
      add_person
    when '4'
      add_book
    when '5'
      add_rental
    when '6'
      list_by_person
    when '7'
      exit
    else
      puts 'Invalid input'
    end
    puts ''
    main
  end
end

school_library = SchoolLibrary.new
school_library.main

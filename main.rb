require_relative 'app_functions'
require_relative 'add_person'

class SchoolLibrary
  def initialize
    @people = []
    @books = []
    @rentals = []
    add_saved_books
    add_saved_people
    add_saved_rentals
  end

  def main_menu
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

  include AppFunctions
  include AddPerson

  # rubocop:disable Metrics/CyclomaticComplexity
  def select_menu(selection)
    case selection
    when '1' then list_books
    when '2' then list_people
    when '3' then add_person
    when '4' then add_book
    when '5' then add_rental
    when '6' then list_by_person
    when '7' then exit
    else
      invalid_input
    end
    puts
    main_menu
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def add_saved_people
    return unless File.exist?('people.json')

    JSON.parse(File.read('people.json')).each do |person|
      case person['type']
      when 'Student'
        @people << Student.new(age: person['@age'], name: person['@name'],
                               parent_permission: person['@parent_permission'])
      when 'Teacher'
        @people << Teacher.new(age: person['@age'], name: person['@name'], specialization: person['@specialization'])
      end
    end
  end

  def add_saved_books
    return unless File.exist?('books.json')

    JSON.parse(File.read('books.json')).each do |book|
      @books << Book.new(book['@title'], book['@author'])
    end
  end

  def add_saved_rentals
    return unless File.exist?('rentals.json')

    JSON.parse(File.read('rentals.json')).each do |rental|
      person_index = @people.find_index { |person| person.name == rental['name'] }
      book_index = @books.find_index { |book| book.title == rental['book'] }
      @rentals << Rental.new(@people[person_index], @books[book_index], rental['date'])
    end
  end
end

SchoolLibrary.new.main_menu

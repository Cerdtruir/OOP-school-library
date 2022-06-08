require_relative 'add_person'

class SchoolLibrary
  def initialize
    @books = []
    @people = []
    add_saved_people
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
        @people << Student.new(age: person['@age'], name: person['@name'], parent_permission: person['@parent_permission'])
      when 'Teacher'
        @people << Teacher.new(age: person['@age'], name: person['@name'], specialization: person['@specialization'])
      end
    end
  end

end

SchoolLibrary.new.main_menu

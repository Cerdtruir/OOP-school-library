require_relative 'app'

class SchoolLibrary
  def initialize
    @app = App.new(invalid_input_callback: -> { main_menu })
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

  attr_reader :app

  # rubocop:disable Metrics/CyclomaticComplexity
  def select_menu(selection)
    case selection
    when '1' then app.list_books
    when '2' then app.list_people
    when '3' then app.add_person
    when '4' then app.add_book
    when '5' then app.add_rental
    when '6' then app.list_by_person
    when '7' then exit
    else
      app.invalid_input
    end
    puts
    main_menu
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end

SchoolLibrary.new.main_menu

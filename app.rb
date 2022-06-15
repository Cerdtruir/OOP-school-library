require 'json'

require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

# rubocop:disable Metrics/ClassLength
class App
  class InvalidInputError < StandardError; end

  def initialize
    @people = []
    @books = []
    @rentals = []
    add_saved_people
    add_saved_books
    add_saved_rentals
  end

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

  def list_books
    @books.each { |book| puts "Title: '#{book.title}', Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def add_person
    person_type = choose_person_type

    invalid_input if person_type != '1' && person_type != '2'

    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp

    invalid_input unless /\A\d+\z/.match(age)

    case person_type
    when '1'
      add_student(name, age)
    when '2'
      add_teacher(name, age)
    end

    save_people

    puts
    puts "Successfully added #{name}"
  end

  def choose_person_type
    puts 'Please select the type of person you would like to add: '
    puts '1 - Student'
    puts '2 - Teacher'
    gets.chomp
  end

  def add_student(name, age)
    print 'Does the student have parental permission? [Y/N]: '
    permission = gets.chomp

    case permission.upcase
    when 'Y'
      permission = true
    when 'N'
      permission = false
    else
      invalid_input
    end

    @people << Student.new(age: age, name: name, parent_permission: permission)
  end

  def add_teacher(name, age)
    print 'Specialization:'
    specialization = gets.chomp

    @people << Teacher.new(age: age, name: name, specialization: specialization)
  end

  def save_people
    save_data_array = []
    @people.each do |person|
      save_person = {}
      save_person['type'] = person.class.name
      person.instance_variables.map do |attribute|
        save_person[attribute] = person.instance_variable_get(attribute)
      end
      person.rentals.instance_variables.map do |attribute|
        save_person.rentals[attribute] = person.instance_variable_get(attribute)
      end
      save_data_array << save_person
    end
    File.write('people.json', save_data_array.to_json)
  end

  def add_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    save_books
    puts 'The book has been successfully added'
    puts
  end

  def save_books
    save_data_array = []
    @books.each do |book|
      save_book = {}
      book.instance_variables.map do |attribute|
        save_book[attribute] = book.instance_variable_get(attribute)
      end
      save_data_array << save_book
    end
    File.write('books.json', save_data_array.to_json)
  end

  def add_rental
    puts 'Select a person by entering the list number'
    list_people_with_index
    person_index = gets.chomp.to_i

    invalid_input unless person_index.between?(0, @people.length - 1)

    puts 'Select a book by entering the list number'
    @books.each_with_index do |book, index|
      puts "#{index}: Title: #{book.title}, Author: #{book.author}"
    end

    book_index = gets.chomp.to_i

    invalid_input unless book_index.between?(0, @books.length - 1)

    print 'Date of renting: '
    date = gets.chomp
    @rentals << Rental.new(@people[person_index], @books[book_index], date)
    save_rentals
    puts 'Rental added'
  end

  def save_rentals
    save_data_array = []
    @rentals.each do |rental|
      save_data_array << { 'name' => rental.person.name, 'book' => rental.book.title, 'date' => rental.date }
    end
    File.write('rentals.json', save_data_array.to_json)
  end

  def list_by_person
    puts 'Select a person by entering the list number'
    list_people_with_index
    person_index = gets.chomp.to_i

    invalid_input unless person_index.between?(0, @people.length - 1)

    puts

    @people[person_index].rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
  end

  def list_people_with_index
    @people.each_with_index do |person, index|
      puts "#{index}: [#{person.class.name}] Name: #{person.name}, Age: #{person.age}"
    end
  end

  def invalid_input
    raise InvalidInputError
  end
end
# rubocop:enable Metrics/ClassLength

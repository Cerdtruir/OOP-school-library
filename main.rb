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
    when '1' then books.each { |book| puts "#{book.title} #{book.author}" }
    when '2' then people.each { |person| puts person.name }
    when '3' then choose_person_type
    when '4' then add_book
    when '5' then add_rental
    when '6' then list_by_person
    when '7' then exit
    end
    puts ''
    main
  end

  def add_book
    puts "Please type the book's name:"
    title = gets.chomp
    puts "Please type the author's name:"
    author = gets.chomp
    books << Book.new(title, author)
    puts 'The book has been successfully added'
    main
  end

  def choose_person_type
    puts 'Please select the type of person you would like to add: '
    puts '1 - Student'
    puts '2 - Teacher'
    person_type = gets.chomp
    add_person(person_type)
  end

  def add_person(person_type)
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    case person_type
    when '1'
      add_student(name, age)
    when '2'
      add_teacher(name, age)
    else
      puts 'Invalid input'
      main
    end
    puts
    puts "Successfully added #{name}"
  end

  def add_student(name, age)
    print 'Does the student have parental permission? [Y/N]: '
    permission = gets.chomp
    case permission.upcase
    when 'Y'
      p permission = true
    when 'N'
      p permission = false
    else
      puts 'Invalid input'
      main
    end
    people << Student.new(age: age, name: name, parent_permission: permission)
  end

  def add_teacher(name, age)
    print 'Specialization:'
    specialization = gets.chomp
    people << Teacher.new(age: age, name: name, specialization: specialization)
  end
end

school_library = SchoolLibrary.new
school_library.main
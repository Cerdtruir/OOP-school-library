require 'json'

require_relative 'book'
require_relative 'rental'

module AppFunctions
  def list_books
    @books.each { |book| puts "Title: '#{book.title}', Author: #{book.author}" }
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def add_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'The book has been successfully added'
    puts
  end

  def add_rental
    puts 'Select a person by entering the list number'
    @people.each_with_index do |person, index|
      puts "#{index}: [#{person.class.name}] Name: #{person.name}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    invalid_input unless person_index.between?(0, @people.length - 1)
    puts 'Select a book by entering the list number'
    @books.each_with_index do |book, index|
      p index
      puts "#{index}: Title: #{book.title}, Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    invalid_input unless person_index.between?(0, @books.length - 1)
    print 'Date of renting: '
    date = gets.chomp
    puts 'Rental added'
  end

  def list_by_person
    puts 'Select a person by entering the list number'
    @people.each_with_index do |person, index|
      puts "#{index}: [#{person.class.name}] Name: #{person.name}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    invalid_input unless person_index.between?(0, @people.length - 1)
    puts
    @people[person_index].rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
    end
  end

  def invalid_input
    puts
    puts 'Invalid input'
    puts 'Press enter to go to the main menu'
    gets.chomp
    main_menu
  end
end

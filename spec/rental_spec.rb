require_relative '../book'
require_relative '../person'
require_relative '../rental'

describe Rental do
  context 'When making a rental' do
    book = Book.new('title', 'author')
    person = Person.new(age: 0, name: 'name', parent_permission: true)
    rental = Rental.new(person, book, '2000/01/01')

    it 'returns the correct person' do
      expect(rental.person).to eq person
    end

    it 'returns the correct book' do
      expect(rental.book).to eq book
    end

    it 'gets added to the person object' do
      expect(rental).to eq person.rentals.last
    end

    it 'gets added to the book object' do
      expect(rental).to eq book.rentals.last
    end
  end
end

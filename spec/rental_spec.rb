require_relative '../book'
require_relative '../person'
require_relative '../rental'

describe Rental do
  context 'Make a rental' do
    book = Book.new('title', 'author')
    person = Person.new(age: 0, name: 'name', parent_permission: true)
    rental = Rental.new(person, book, '2000/01/01')

    it 'Does the rental have the correct person' do
      expect(rental.person).to eq person
    end
    it 'Does the rental have the correct book' do
      expect(rental.book).to eq book
    end
    it 'Does the person have the correct rental' do
      expect(rental).to eq person.rentals.last
    end
    it 'Does the book have the correct rental' do
      expect(rental).to eq book.rentals.last
    end
  end
end

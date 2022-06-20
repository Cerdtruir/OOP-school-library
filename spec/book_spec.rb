require_relative '../book'
require_relative '../person'
require_relative '../rental'

describe Book do
  book = Book.new('title', 'author')

  context 'When making a book' do
    it 'returns the correct title' do
      expect(book.title).to eq 'title'
    end

    it 'returns the correct author' do
      expect(book.author).to eq 'author'
    end
  end

  context 'When adding a rental to the book' do
    person = Person.new(age: 0, name: 'name', parent_permission: false)
    rental = book.add_rental(person, '2022/10/10')

    it 'returns the added rental' do
      expect(book.rentals.last).to eq rental
    end
  end
end

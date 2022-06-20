require_relative '../book'
require_relative '../person'
require_relative '../rental'

describe Person do
  person = Person.new(age: 0, name: 'name', parent_permission: true)

  context 'When making a person' do
    it 'returns an id' do
      expect(person.id).to be >= 0
    end

    it 'returns the correct age' do
      expect(person.age).to eq 0
    end

    it 'returns the correct name' do
      expect(person.name).to eq 'name'
    end

    it 'returns the correct parent permission' do
      expect(person.parent_permission).to eq true
    end
  end

  context 'when there a missing arguments' do
    it 'returns the default values' do
      person_default = Person.new(age: 0)
      expect(person_default.name).to eq 'Unknown'
      expect(person_default.parent_permission).to eq true
    end
  end

  context 'Whn using methods' do
    it 'can add a rental to a person correctly' do
      book = Book.new('title', 'author')
      rental = person.add_rental(book, '2022/10/10')
      expect(person.rentals.last).to eq rental
    end

    it 'can use services where permission true' do
      expect(person.can_use_services?).to eq true
    end

    it 'cannot use services where permission false' do
      person2 = Person.new(age: 0, name: 'name', parent_permission: false)
      expect(person2.can_use_services?).to eq false
    end

    it 'can use services where age old enough' do
      person3 = Person.new(age: 20, name: 'name', parent_permission: false)
      expect(person3.can_use_services?).to eq true
    end

    it 'validates the name correctly' do
      person3 = Person.new(age: 20, name: 'nameAFrsdfRrtefdg', parent_permission: false)
      expect(person3.validate_name).to eq 'Nameafrsdfr'
    end
  end
end

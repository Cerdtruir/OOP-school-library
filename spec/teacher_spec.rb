require_relative '../teacher'
require_relative '../person'

describe Teacher do
  it 'Is teacher a subclass of person' do
    expect(Teacher).to be < Person
  end
  teacher = Teacher.new(specialization: 'specialization_0', age: 0, name: 'name')
  context 'Make a teacher' do
    it 'Specialization is correct?' do
      expect(teacher.specialization).to eq 'specialization_0'
    end
  end
  context 'Do teacher methods work' do
    it 'Method can_use_services? is true' do
      expect(teacher.can_use_services?).to eq true
    end
  end
end

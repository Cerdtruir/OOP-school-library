require_relative '../teacher'
require_relative '../person'

describe Teacher do
  it 'checks if the teacher class is a subclass of person' do
    expect(Teacher).to be < Person
  end

  teacher = Teacher.new(specialization: 'specialization_0', age: 0, name: 'name')

  context 'When making a teacher' do
    it 'returns the correct specialization' do
      expect(teacher.specialization).to eq 'specialization_0'
    end
  end

  context 'Testing can_use_services? methtod' do
    it 'returns true on can_use_services? method' do
      expect(teacher.can_use_services?).to eq true
    end
  end
end

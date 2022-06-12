require_relative '../student'
require_relative '../classroom'
require_relative '../person'

describe Student do
  it 'Is student a subclass of person' do
    expect(Student).to be < Person
  end
  student = Student.new(age: 0, name: 'name', parent_permission: true)
  context 'Add a student' do
    it 'Method play hooky working?' do
      expect(student.play_hooky).to eq "¯\(ツ)/¯"
    end
    it 'Does the book have the added classsroom' do
      student.classroom = 'asd'
      expect(classroom0.last).to eq student
    end
  end
end

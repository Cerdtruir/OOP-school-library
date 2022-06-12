require_relative '../student'
require_relative '../classroom'
require_relative '../person'

describe Student do
  it 'Is student a subclass of person' do
    expect(Student).to be < Person
  end
  student = Student.new(age: 0, name: 'name', parent_permission: true)
  context 'Do student methods work' do
    it 'Method play hooky working?' do
      expect(student.play_hooky).to eq "¯\(ツ)/¯"
    end
    it 'Does the student have the added classsroom' do
      classroom0 = Classroom.new('0')
      student.classroom = classroom0
      expect(classroom0.students.last).to eq student
    end
  end
end

require_relative '../student'
require_relative '../classroom'
require_relative '../person'

describe Student do
  it 'checks if the student class is a subclass of person' do
    expect(Student).to be < Person
  end

  student = Student.new(age: 0, name: 'name', parent_permission: true)

  context 'Testing student methods' do
    it 'returne the corrrect string when using play_hooky' do
      expect(student.play_hooky).to eq "¯\(ツ)/¯"
    end

    it 'returns the correct added classsroom on both objects' do
      classroom0 = Classroom.new('0')
      student.classroom = classroom0
      expect(classroom0.students.last).to eq student
    end
  end
end

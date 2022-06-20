require_relative('../classroom')
require_relative('../student')

describe Classroom do
  classroom = Classroom.new('classroom')

  context 'When making a classroom' do
    it 'returns the correct label' do
      expect(classroom.label).to eq 'classroom'
    end
  end

  context 'Adding a student to the classroom' do
    it 'adds the student to the classroom correctly' do
      student = Student.new(age: 0, name: 'name', parent_permission: true)
      classroom.add_student(student)
      expect(classroom.students.last).to eq student
    end
  end
end

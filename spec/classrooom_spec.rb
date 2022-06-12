require_relative('../classroom')
require_relative('../student')

describe Classroom do
  classroom = Classroom.new('classroom')
  context 'Make a classroom' do
    it 'Is the clasroom made correcly?' do
      expect(classroom.label).to eq 'classroom'
    end
    it 'add_student method works correctly?' do
      student = Student.new(age: 0, name: 'name', parent_permission: true)
      classroom.add_student(student)
      expect(classroom.students.last).to eq student
    end
  end
end

require_relative 'teacher'
require_relative 'student'

module AddPerson
  def add_person
    person_type = choose_person_type
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp
    invalid_input unless /\A\d+\z/.match(age)
    case person_type
    when '1'
      add_student(name, age)
    when '2'
      add_teacher(name, age)
    end
    save_people
  end

  def choose_person_type
    puts 'Please select the type of person you would like to add: '
    puts '1 - Student'
    puts '2 - Teacher'
    person_type = gets.chomp
    invalid_input if person_type != '1' && person_type != '2'
    person_type
  end

  def add_student(name, age)
    print 'Does the student have parental permission? [Y/N]: '
    permission = gets.chomp
    case permission.upcase
    when 'Y'
      permission = true
    when 'N'
      permission = false
    else
      invalid_input
    end
    @people << Student.new(age: age, name: name, parent_permission: permission)
  end

  def add_teacher(name, age)
    print 'Specialization:'
    specialization = gets.chomp
    @people << Teacher.new(age: age, name: name, specialization: specialization)
  end

  def save_people
    save_data_array = []
    @people.each do |person|
      save_person = {}
      save_person['type'] = person.class.name
      person.instance_variables.map do |attribute|
        save_person[attribute] = person.instance_variable_get(attribute)
      end
      person.rentals.instance_variables.map do |attribute|
        save_person.rentals[attribute] = person.instance_variable_get(attribute)
      end
      save_data_array << save_person
    end
    File.write('people.json', save_data_array.to_json)
  end
end

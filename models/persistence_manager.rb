require 'yaml/store'


class PersistenceManager

  def initialize
    @obras_file = YAML::Store.new 'obras.yml'
    @obras_file.transaction do
      @obras_file['obras_list'] = [] if @obras_file['obras_list'].nil?
    end
  end

  def add_obra(obra)
    raise ObraException.new 'Obra already exists' if obras_list.include?(obra)
    @obras_file.transaction do
      @obras_file['obras_list'] << obra
    end
  end

  def obras_list
    @obras_file.transaction do
      @obras_file['obras_list']
    end
  end

  def get_obra_by_id(obra_id)
    selected_obras = obras_list.select{ |obra| obra.id == obra_id}
    selected_obras.first
  end

  def delete_obra_by_id(obra_id)
    student = get_obra_by_id obra_id
    raise ObraException.new 'Obra not found by id' if obra.nil?
    @obras_file.transaction do
      @obras_file['obras_list'].delete_if {|obra| obra.id == obra_id}
    end
  end

  def edit_obra(new_obra)
    old_obra = get_obra_by_id(new_obra.id)
    raise ObraException.new 'Obra not found by id' if old_obra.nil?
    @obra_file.transaction do
      @obra_file['obras_list'].delete(old_obra)
      @obra_file['obras_list'] << new_obra
    end
  end


end





=begin
  

class PersistenceManager

  def initialize
    @student_file = YAML::Store.new 'students.yml'
    @student_file.transaction do
      @student_file['student_list'] = [] if @student_file['student_list'].nil?
    end
  end

  def add_student(student)
    raise StudentException.new 'Student already exists' if student_list.include?(student)
    @student_file.transaction do
      @student_file['student_list'] << student
    end
  end

  def student_list
    @student_file.transaction do
      @student_file['student_list']
    end
  end

  def get_student(student_email)
    selected_students = student_list.select{ |student| student.email == student_email}
    selected_students.first
  end

  def delete_student(student_email)
    student = get_student student_email
    raise StudentException.new 'Student not found by email' if student.nil?
    @student_file.transaction do
      @student_file['student_list'].delete_if {|student| student.email == student_email}
    end
  end

  def edit_student(new_student)
    old_student = get_student(new_student.email)
    raise StudentException.new 'Student not found by email' if old_student.nil?
    @student_file.transaction do
      @student_file['student_list'].delete(old_student)
      @student_file['student_list'] << new_student
    end
  end

end

=end



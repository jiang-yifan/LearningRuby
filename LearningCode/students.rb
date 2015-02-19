class Student
  attr_accessor :first, :last
  def initialize first, last
    @first, @last = first, last
    @courses = []
  end

  def name
    "#{ first } #{ last }"
  end

  def courses
    @courses
  end

  def enroll course
    unless has_conflict? course
      courses << course
      course.add_student (self)
    else
      puts "You have a conflict."
    end
  end

  def has_conflict? course
    courses.any? do |enrolled_course|
      enrolled_course.conflicts_with? course
    end
  end

  def course_load
    store = Hash.new 0 #hash with default val of zero
    courses.each do |course|
      # if store[course.department] == nil
      #   store[course.department] = course.credits
      # else
        store[course.department] += course.credits
      # end
    end
    store
  end
end

class Course
  attr_reader :department, :credits, :days

  def initialize course_name, department, credits, days = {}
    @course_name, @department, @credits = course_name, department, credits
    @students = []
    @days = days
  end

  def students
    @students
  end

  def add_student student
    students << student
  end

  def conflicts_with? course
    days.each_key do |day|
      return true if days[day] == course.days[day]
    end
    false
  end
end

student = Student.new( "matt", "thomas")
course = Course.new( "math", "math", 54, {mon: 1})
course2 = Course.new("math", 'Math', 10, {mon: 1})
student.enroll course
student.enroll course2
student.courses
course.students
student.course_load
p course.conflicts_with? course2

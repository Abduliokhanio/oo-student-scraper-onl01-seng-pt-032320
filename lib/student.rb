require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #binding.pry
    @name = student_hash[:name]
    @location = student_hash[:location]

    @@all << self
  end

  def self.create_from_collection(students_array)

    epoc = 0
    while epoc < students_array.length
      Student.new(students_array[epoc])
      epoc += 1
    end

  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each do |key,value|
        self.send("#{key}=&quot" , value)
      end
  end

  def self.all

  end
end

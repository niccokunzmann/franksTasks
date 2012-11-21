require 'maglev_model2'

class AppTask
  include Maglev::Model

  attr_reader :description, :title, :timestamp, :tags, :dueDate, :isCompleted
  def initialize(params)
    @title = params[:title]
    @description =  params[:description]
    @timestamp = Time.now
    @dueDate = params[:dueDate]
    @isCompleted = params[:isCompleted].to_i
  end
  
  def to_s
    "Title: #{@title}, Text: #{@description}, ID: #{__id__}"
  end

  def done
    @isCompleted = true
  end
  
  def self.findById(id)
    puts "In method"
    AppTask.detect {|t| 
      puts "ID:::::::#{t.__id__}" 
      t.__id__.to_i == id.to_i}
  end
end
class AppUser
  include Maglev::Model
  
  attr_reader :login, :password, :tasks
  
  def initialize(params)
    @login = params[:login]
    @password = params[:password]
    @tasks = []
  end
  
  def to_s
    "#{@login} #{@password}"
  end
  
  def self.validateUser(login, password)
    AppUser.detect {|u| (u.login == login) and (u.password == password)}
  end
  
  def addTask(task)
    @tasks << task
  end
end

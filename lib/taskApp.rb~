require 'maglev_model'

class SimpleTask
  include Maglev::Model

  attr_reader :description, :title, :timestamp, :tags, :dueDate, :isCompleted
  def initialize(params)
    @title = params[:title]
    @description =  params[:description]
    @timestamp = Time.now
    @dueDate = params[:dueDate]
    @isCompleted = params[:isCompleted]
  end

  def done
    @isCompleted = true
  end
end
class AppUser
  include Maglev::Model
  
  attr_reader :login, :password, :tasks
  
  def initialize(login, password)
    @login = login.to_s
    @password = password.to_s
    @tasks = []
  end
  
  def to_s
    @login
  end
  
  def self.validateUser(login, password)
    user = AppUser.detect {|u| u.login == login and u.password == password}
    return !user.nil?
  end
  
  def addTask(task)
    @tasks << task
  end
end

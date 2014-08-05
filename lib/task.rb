require 'pg'

class Task
  attr_reader :name, :list_id, :completed

  def initialize(attributes)
    @name = attributes['name']
    @list_id = attributes['list_id']
    @completed = attributes['completed'] || false
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      completed = result['completed']
      puts completed
      tasks << Task.new({'name' => name, 'list_id' => list_id, 'completed' => completed})
    end
    tasks
  end

  def delete_task(user_del)
    DB.exec("DELETE FROM tasks WHERE (name) = '#{user_del}';")
  end

  def specific_tasks(user_id)
    DB.exec("SELECT FROM tasks WHERE list_id = #{user_id};")
  end

  def complete_task
    # puts self.completed
    DB.exec("UPDATE tasks SET completed = true WHERE (name) = '#{self.name}';")
    @completed = true
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id, completed) VALUES ('#{@name}', #{@list_id}, #{completed})")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end
end


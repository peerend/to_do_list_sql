require 'date'
require 'pg'

class Task
  attr_reader :name, :list_id, :completed, :due_date

  def initialize(attributes)
    @name = attributes['name']
    @list_id = attributes['list_id']
    @completed = attributes['completed'] || false
    @due_date = attributes['due_date'] || Date.today
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      completed = result['completed']
      due_date = result['due_date']
      tasks << Task.new({'name' => name, 'list_id' => list_id, 'completed' => completed, 'due_date'=> due_date})
    end
    tasks
  end

  def delete_task(user_del)
    DB.exec("DELETE FROM tasks WHERE (name) = '#{user_del}';")
  end

  def specific_tasks(user_id)
    DB.exec("SELECT FROM tasks WHERE list_id = #{user_id};")
  end

  def complete_task(user_comp)
    DB.exec("UPDATE tasks SET completed = true WHERE (name) = '#{user_comp}';")
    @completed = true
  end

  def add_deadline(user_date)
    DB.exec("UPDATE tasks SET due_date = '#{user_date}';")
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id, completed, due_date) VALUES ('#{@name}', #{@list_id}, #{@completed}, '#{@due_date}');")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end
end


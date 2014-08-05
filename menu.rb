require './lib/list'
require './lib/task'
require 'pg'
DB = PG.connect({:dbname => 'to_do_test'})

def main_menu

  loop do

    puts "Press 'i' to input a task"
    puts "Press 'd' to delete a task"
    puts "Press 'l' to list tasks"
    puts "Press 'x' to exit"

    user_input = gets.chomp
    case user_input
      when 'i'
        task_input
      when 'l'
        task_list
      when 'd'
        task_delete
      when 'x'
        puts "Goodbye!"
        sleep 1
        DB.exec("DELETE FROM tasks *;")
        exit
      else
        puts "Please enter a valid input!"
    end
  end
end

def task_input
  puts "Input a task"
  task = gets.chomp.to_s
  task_input = {'name'=> task}
  new_task = Task.new(task_input)
  new_task.save
end

def task_delete
  puts "Input a task to delete"
  task_input = gets.chomp.to_s
  Task.all.each do |task|
    if task.name == task_input
      task.delete_task(task_input)
    end
  end
end

def task_list
  puts "Here are your tasks!"
  Task.all.each do |task|
    puts task.name
  end
end
main_menu

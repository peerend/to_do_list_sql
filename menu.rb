require './lib/list'
require './lib/task'
require 'pg'
DB = PG.connect({:dbname => 'to_do_test'})

def main_menu

  loop do
    puts "Type 'add' to add a list"
    puts "Typle 'lists' to list your lists"
    puts "Press 'i' to input a task"
    puts "Press 'd' to delete a task"
    puts "Press 'l' to list tasks"
    puts "Press 'ld' to delete lists"
    puts "Press 'x' to exit"

    user_input = gets.chomp
    case user_input
      when 'add'
        add_list
      when 'i'
        task_input
      when 'ld'
        list_delete
      when 'lists'
        list_lists
      when 'l'
        task_list
      when 'd'
        task_delete
      when 'x'
        puts "Goodbye!"
        sleep 1
        DB.exec("DELETE FROM tasks *;")
        DB.exec("DELETE FROM lists *;")
        exit
      else
        puts "Please enter a valid input!"
    end
  end
end

def add_list
  puts "Input a list"
  user_input = gets.chomp.to_s
  new_list = List.new({'name'=>user_input})
  new_list.save
end

def list_delete
  list_lists
  puts "Input a list id to delete"
  user_input = gets.chomp.to_i
  List.all.each do |list|
    if list.id == user_input
      list.delete_list(user_input)

    end
  end
end

def list_lists
  puts "Here are your lists"
  List.all.each do |list|
    puts "Name: " + "#{list.name}" + " ID: " + "#{list.id}"
  end
end

def task_input
  list_lists
  puts "choose a list id to add to"
  user_id = gets.chomp.to_i
  puts "Input a task"
  task = gets.chomp.to_s
  task_input = {'name'=> task, 'list_id' => user_id}
  new_task = Task.new(task_input)
  new_task.save
end

def task_delete
  task_list
  puts "Input a task to delete"
  task_input = gets.chomp.to_s
  Task.all.each do |task|
    if task.name == task_input
      task.delete_task(task_input)
    end
  end
end

def task_list
  list_lists
  puts "Input a specific list"
  user_id = gets.chomp.to_i
  puts "Here are your tasks!"
  Task.all.each do |task|
    if task.list_id == user_id
      puts task.name
    end
  end
end
main_menu

require 'spec_helper'

describe Task do
  it 'is initialized with a hash of attributes' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.should be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.name.should eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.list_id.should eq 1
  end

  it 'starts off with no tasks' do
    Task.all.should eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 0})
    task.save
    Task.all.should eq [task]
  end

  it 'lets you delete tasks from the database' do
    task = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task.save
    task.delete_task('learn SQL')
    Task.all.should eq []
  end

  it 'is the same task if it has the same name and list ID' do
    task1 = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task2 = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task1.should eq task2
  end

  it 'marks a task complete' do
    task1 = Task.new({'name' => 'learn SQL', 'list_id' => 1})
    task1.save
    task1.complete_task('learn SQL')
    Task.all[0].completed.should eq 't'
  end

  it 'initializes a task with a due date' do
    task1 = Task.new({'name'=> 'give date', 'list_id'=>1, 'due_date' => '2014-8-10'})
    task1.save
    task1.due_date.should eq '2014-8-10'
  end

  it 'sets a due date for a given task' do
    task1 = Task.new({'name'=> 'give date', 'list_id'=>1})
    task1.save
    task1.add_deadline('2014-10-11')
    Task.all[0].due_date.should eq '2014-10-11 00:00:00'
  end

  it 'sets a due date for today for a given task' do
    task1 = Task.new({'name'=> 'give date', 'list_id'=>1})
    task1.save
    Task.all[0].due_date.should eq '2014-08-06 00:00:00'
  end
end

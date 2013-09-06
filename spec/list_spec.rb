require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    task = List.new('Epicodus stuff')
    task.should be_an_instance_of List
  end

  it 'tells you its name' do
    task = List.new('Epicodus stuff')
    task.name.should eq 'Epicodus stuff'
  end

  it 'is the same list if it has the same name' do
    list1 = List.new('Epicodus stuff')
    list2 = List.new('Epicodus stuff')
    list1.should eq list2
  end

  it 'starts off with no lists' do
    List.all.should eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('learn SQL')
    list.save
    List.all.should eq [list]
  end

  it 'sets its ID when you save it' do
    list = List.new('learn SQL')
    list.save
    list.id.should be_an_instance_of Fixnum
  end
end

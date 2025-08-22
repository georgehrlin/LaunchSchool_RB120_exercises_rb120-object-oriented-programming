=begin
I couldn't detect what problem this faulty code would run into without running
it, so I went ahead and ran it. The error message told me that a NoMethodError
was raised by line 35 and apparently the receiver tasks of select points to
nil. This is quite strange.

Here, the tasks in tasks.select is meant to be the getter method to access
@tasks. However, it fails to do so and points to nil instead. This is abnormal
behaviour, but my hunch is that it's because of the tasks to the left of = on
line 35. This other tasks (on the left side of =) is meant to be a local
variable initiation. However, having it there and letting it have the same name
as the getter method tasks makes Ruby initiate it as a local variable with the
value nil when the code is first interpreted. Therefore, now that the local
variable tasks points to nil within the scope of the definition of
display_high_priority_tasks, the aforementioned error is caused.
=end

# My fix:
class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    tasks = self.tasks.select do |task|
      task.priority == :high
    end

    display(tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks
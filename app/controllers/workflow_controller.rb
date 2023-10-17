class WorkflowController < ApplicationController
  before_action :authorize!
  before_action :identify!

  public
  def create
    day = Date.parse(params['date'])
    puts(day)
    if @user.nil?
      throw ActiveRecord::RecordNotFound
    end
    puts(@user.auth0Id)
    @profile = @user.profile
    @sleep = Task.create(title: "sleep", description: "sleep", start: @profile.start_sleep, end: @profile.end_sleep, unmovable: true, author_id: @user.auth0Id, done:false)
    @work = Task.create(title: "work", description: "work", start: @profile.start_work, end: @profile.end_work, unmovable: true, author_id: @user.auth0Id, done:false)
    @tasks = @user.tasks
    @tasks.each do |task|
      puts(task.title)
    end
    @unplaced_tasks = Array.new
    @unmovable_tasks = @tasks.where(unmovable: true)
    @tasks = @tasks.where(unmovable: false)
    puts(@unmovable_tasks[0].title)
    @tasks = @tasks.sort_by { |task |  task.end - task.start }
    @tasks.each do |task|
      puts("oui")
      start = task.start.to_date
      puts(start)
      if start != day
        @tasks.delete(task)
      end
    end
    @tasks.each do |task|
      puts(task.start)
    end
    period = @profile.prod_period
    puts(period)
    end_work = @profile.end_work
    end_sleep = @profile.end_sleep
    delta = 0
    start_tasks = period == "before" ? end_sleep : end_work
    @tasks.each do |task|
      puts("start")
      duration = task.end - task.start
      task.start = start_tasks + delta
      puts(task.start)
      task.end = task.start + duration
      delta += duration
      puts(cover(task, @unmovable_tasks, period))
      while cover(task, @unmovable_tasks, period)
        puts("cover")
        puts(cover(task, @unmovable_tasks, period))
        if cover(task, @unmovable_tasks, period) == "impossible"
          @unplaced_tasks.push(task.id)
          break
        end
        task.start = cover(task, @unmovable_tasks, period)
        puts(task.start)
        task.end = task.start + duration
      end
      unless @unplaced_tasks.empty?
        break
      end
      task.unmovable = true
      task.save
    end
    puts("couldn't place tasks")
    @unplaced_tasks.each do |task|
      puts(task)
    end
    Task.delete(@sleep)
    Task.delete(@work)
    @tasks.each do |task|
      task.unmovable = false
    end
    render json: @tasks
  end

  def index
    render json: @tasks
  end

  def cover(*args)
    if args[0].nil? || args[1].nil?
      return false
    end
    task = args[0]
    @unmovable_tasks = args[1]
    @period = args[2]
    @sleep = @unmovable_tasks.where(title: "sleep")
    @work = @unmovable_tasks.where(title: "work")
    @unmovable_tasks.each do |unmovable_task|
      if task.end > unmovable_task.start && task.end < unmovable_task.end || task.start > unmovable_task.start && task.start < unmovable_task.end
        if @period == "after" && unmovable_task.title == "work" || @period == "before" && unmovable_task.title == "sleep"
          puts("non")
          return "impossible"
        end
        puts("oui")
        return unmovable_task.end
      end
    end
    return false
  end

end
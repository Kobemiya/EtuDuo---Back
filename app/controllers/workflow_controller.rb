class WorkflowController < ApplicationController
  before_action :authorize!
  before_action :identify!

  public
  def create
    day = Date.parse(params['date'])
    if @user.nil?
      throw ActiveRecord::RecordNotFound
    end
    @profile = @user.profile
    @sleep = Task.create(title: "sleep", description: "sleep", start: @profile.start_sleep, end: @profile.end_sleep, unmovable: true, author_id: @user.auth0Id, done:false)
    @work = Task.create(title: "work", description: "work", start: @profile.start_work, end: @profile.end_work, unmovable: true, author_id: @user.auth0Id, done:false)
    @tasks = @user.tasks
    @unplaced_tasks = Array.new
    @unmovable_tasks = @tasks.where(unmovable: true)
    @tasks = @tasks.where(unmovable: false)
    @tasks = @tasks.sort_by { |task |  task.end - task.start }
    @tasks.each do |task|
      start = task.start.to_date
      if start != day
        @tasks.delete(task)
      end
    end
    period = @profile.prod_period
    end_work = @profile.end_work
    end_sleep = @profile.end_sleep
    delta = 0
    start_tasks = period == "before" ? end_sleep : end_work
    @tasks.each do |task|
      duration = task.end - task.start
      task.start = start_tasks + delta
      task.end = task.start + duration
      delta += duration
      while cover(task, @unmovable_tasks, period)
        if cover(task, @unmovable_tasks, period) == "impossible"
          @unplaced_tasks.push(task.id)
          break
        end
        task.start = cover(task, @unmovable_tasks, period)
        task.end = task.start + duration
      end
      unless @unplaced_tasks.empty?
        break
      end
      task.unmovable = true
      task.save
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
          return "impossible"
        end
        return unmovable_task.end
      end
    end
    return false
  end

end
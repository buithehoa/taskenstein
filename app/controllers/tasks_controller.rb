class TasksController < ApplicationController
  before_action :set_task, only: %i[ complete show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @pagy, @tasks = pagy(Task.all.where(completed: false).order(:due_at))
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: @task }) }
    end
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'Task was successfully created.' }
        format.turbo_stream { render partial: "shared/redirect", locals: { url: tasks_path } }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: @task }) }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.turbo_stream { render partial: "shared/redirect", locals: { url: tasks_path } }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("task_form", partial: "tasks/form", locals: { task: @task }) }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.turbo_stream { render partial: "shared/redirect", locals: { url: tasks_path } }
    end
  end

  def complete
    @task.update(completed: true)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "task_list",
          partial: "tasks/list",
          locals: { tasks: Task.all.where(completed: false) })
      end
      format.html { redirect_to tasks_path, notice: 'Task was successfully completed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to tasks_path, alert: "Task not found." }
        format.turbo_stream { render partial: "shared/redirect", locals: { url: tasks_path } }
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed, :due_at, :priority)
    end
end

class V1::TasksController < ApplicationController
  def index
    render(json: current_user.tasks, status: :ok, namespace: V1)
  end

  def create
    task = Task.new(task_params)
    task.user = current_user

    if task.save
      head :no_content
    else
      render(json: task.errors, status: :unprocessable_entity, namespace: V1)
    end
  end

  def complete
    task.update_attribute(:complete, true)

    head :no_content
  end

  def undo_complete
    task.update_attribute(:complete, false)

    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:title, :active, :complete)
  end

  def task
    @task ||= Task.find(params[:id])
  end
end

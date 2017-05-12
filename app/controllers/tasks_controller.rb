class TasksController < ApplicationController
  before_action :authenticate_user!
  before_filter :validate_params, except: [:list]

  def create
    task = Task.new(task_params)

    result = if task.save
      {
        message: 'Successfully created a task',
        data: task
      }
    else
      {
        message: 'Failed to create a task',
        data: task.errors.messages
      }
    end

    render_response(result)
  end

  def close
    task = Task.find_by_id(params[:id])
    if task.present?
      task.close
    end
    render_response(result)
  end

  def list
    task_list = Task.list(params[:status])
    render_response(message: 'Success', data: task_list)
  end

  private

  def task_params
    params.require(:task).permit(:name, :tag, :deadline_time)
  end

  def validate_params
    if params[:task].blank?
      render_response(
        { message: 'Failed to create a user due to missing params', data: [] }
      )
      return
    end
  end
end

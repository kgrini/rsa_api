class TasksController < ApplicationController
  before_action :authenticate_user!
  before_filter :validate_params, except: [:list]

  def create
    task = current_user.tasks.new(task_params)

    result = if task.save
      { status: 'success', data: task }
    else
      { message: 'failed', data: task.errors.messages }
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
    render_response(status: 'success', data: task_list)
  end

  private

  def task_params
    params.require(:task).permit(:tag, :deadline_time)
  end

  def validate_params
    if params[:task].blank?
      render_response(
        { status: 'failed', data: [] }
      )
      return
    end
  end
end

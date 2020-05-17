class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # margeメソッドでハッシュを結合(user_id情報)
    # @task = Task.new(task_params.merge(user_id: current_user.id))
    # 関連付けを利用し記述
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end

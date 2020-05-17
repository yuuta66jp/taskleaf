class TasksController < ApplicationController
  # before_actionメソッドでset_taskメソッドを各アクション前に実行(onlyオプションでactionを指定)
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
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
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
  # 共通化したい処理を定義
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

end

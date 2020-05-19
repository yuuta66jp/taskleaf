class TasksController < ApplicationController
  # before_actionメソッドでset_taskメソッドを各アクション前に実行(onlyオプションでactionを指定)
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).recent
  end

  def show
  end

  def new
    @task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    # 内容の検証を行い問題があればエラーとともにnew画面を表示(問題がなければconfirm_new画面の表示)
    render :new unless @task.valid?
  end

  def create
    # margeメソッドでハッシュを結合(user_id情報)
    # @task = Task.new(task_params.merge(user_id: current_user.id))
    # 関連付けを利用し記述
    @task = current_user.tasks.new(task_params)

    # 戻るボタンの場合内容を引き継いでnew画面の表示
    if params[:back].present?
      render :new
      return
    end

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

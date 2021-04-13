class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy]
  before_action :author, only: [:show, :edit, :update, :destroy]
  
  def new
    @memory = Memory.new
  end

  def create
    @memory = Memory.create(memory_params)
    if @memory.save
      flash[:success] = '登録しました！'
      redirect_to memories_path
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end

  def show
  end

  def index
    @memories = Memory.where(user_id: current_user.id).order(date: "DESC")
  end

  def edit
  end

  def update
    if @memory.update(memory_params)
      flash[:success] = '編集しました。'
      redirect_to memories_path
    else
      flash.now[:danger] = '編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @memory.destroy
    flash[:success] = '削除しました。'
    redirect_to memories_path
  end
  
  private
  
  def set_memory
    @memory = Memory.find(params[:id])
  end
  
  def memory_params
    # .requireメソッド:データのオブジェクト名を定める
    # .permitメソッドで変更・保存できるキーを指定
    params.require(:memory).permit(:title, :date, :content, :user_id)
  end
  
  def author #作成者か
    @memory = Memory.find(params[:id])
    if @memory.user_id.to_i != current_user.id  #@memory.user_idは文字列 ⇒ 整数化
      flash[:danger] = '権限がありません。'
      redirect_to memories_path
    end
  end

end

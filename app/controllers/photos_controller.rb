class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy]
  def new
    @photo = Photo.new
    @memory_id = params[:memory_id]
  end

  def create
    @photo = Photo.new(photo_params)
    @memory_id = params[:photo][:memory_id]
    if @photo.save
      flash[:success] = '登録しました。'
      redirect_to memory_path(@memory_id)
    else
      flash.now[:danger] = '登録できませんでした。'
      render :new
    end
  end

  def show
  end

  def index
    @photos = Photo.where(memory_id: params[:id]).order(date: "DESC")
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      flash[:success] = '編集しました。'
      redirect_to memory_path(@photo.memory_id)
    else
      flash.now[:danger] = '編集できませんでした。'
      render :edit
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = '削除しました。'
    redirect_to memory_path(@photo.memory_id)
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:title, :image, :user_id, :memory_id)
  end
  
  def set_photo
    @photo = Photo.find(params[:id])
  end
  
  def author #作成者か
    @photo = Photo.find(params[:id])
    if @photo.user_id.to_i != current_user.id  #文字列 ⇒ 整数化
      flash[:danger] = '権限がありません。'
      redirect_to memories_path
    end
  end

end

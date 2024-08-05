class Admin::GenresController < ApplicationController
  layout 'admin'
  
  def new
    @genre = Genre.new
  end 
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルの作成に成功しました。"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンルの作成に失敗しました。"
      @genres = Genre.all
      render :"admin/genres/index"
    end
  end
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    flash[:notice] = "ジャンルの削除に成功しました。"
    redirect_to admin_genres_path
  end
  
  private
  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end

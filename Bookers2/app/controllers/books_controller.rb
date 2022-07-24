class BooksController < ApplicationController

  def index
    @book = Book.new #新規投稿はbookのindexページで行うからここに記述
    @books = Book.all #bookの一覧表示
    @user = current_user #現在ログインしているユーザーの編集
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id) #新規投稿したらbookのshowページに遷移
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id) #投稿の更新したらbookのshowページに遷移
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id]) #データ（レコード）を1件取得
    book.destroy #データ（レコード）を削除
    redirect_to books_path #ユーザーの詳細画面へリダイレクト
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
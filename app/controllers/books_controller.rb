class BooksController < ApplicationController
  
   before_action :is_matching_login_user, only: [:edit, :update]
   
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:create] = "You have created book successfully."
      redirect_to @book
    else
      render :new
    end
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
  end
  

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:update] = "You have updated book successfully."
      redirect_to @book
    else
      render :edit
    end
  end
  
  def destroy
    @book = Book.find(params[:id]) 
    @book.destroy
    redirect_to books_path
  end
  
    private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
  
end

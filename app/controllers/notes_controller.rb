class NotesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:show, :destroy, :edit, :update]
  
  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = "Note created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end  

  def index
    @user = User.find(params[:user_id])
    @notes = @user.notes
    @length = @notes.count
  end

  def edit
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(note_params)
      redirect_to @note.user
    else
      render 'edit'
    end

  end

  def show
  end


  def destroy
    @note.destroy
    redirect_to @note.user
  end

  private

    def note_params
      params.require(:note).permit(:content)
    end

    def correct_user 
      @note = Note.find_by(id: params[:id])
      redirect_to root_url unless @note.user_id == current_user.id or @note.user.sharing?(current_user)

      redirect_to root_url if @note.nil?
    end
end
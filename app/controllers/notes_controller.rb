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

  def edit
  end

  def update

  end



  def destroy
    @note.destroy
    redirect_to root_url
  end

  private

    def note_params
      params.require(:note).permit(:content)
    end

    def correct_user
      @note = current_user.notes.find_by(id: params[:id])
      if @note.user_id != current_user.id
        redirect_to root_url 
      redirect_to root_url if @note.nil?
    end
end
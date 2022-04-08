class Public::ProfileCommentsController < ApplicationController

  def create
    @profile = Profile.find(params[:profile_id])
    @comment = current_customer.profile_comments.new(profile_comment_params)
    @comment.profile_id = @profile.id
    @comment.save
    redirect_to profile_path(@profile)
  end

  def destroy
    ProfileComment.find(params[:id]).destroy
    redirect_to profile_path(params[:profile_id])
  end

  private

  def profile_comment_params
    params.require(:profile_comment).permit(:comment)
  end

end

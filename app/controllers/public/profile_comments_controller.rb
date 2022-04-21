class Public::ProfileCommentsController < ApplicationController
  def create
    @profile = Profile.find(params[:profile_id])
    @comment = current_customer.profile_comments.new(profile_comment_params)
    @comment.profile_id = @profile.id
    @comment.save
  end

  def destroy
    @profile = Profile.find(params[:profile_id])
    @profile_comment = ProfileComment.find(params[:id])
    @profile_comment.destroy
  end

  private

  def profile_comment_params
    params.require(:profile_comment).permit(:comment)
  end

end

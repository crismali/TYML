class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save
      TymlMailer.comment_notification(@comment).deliver

      if @comment.tyml.sender_id == @comment.user.id
        redirect_to sent_url
      else
        redirect_to dashboard_url
      end

    else
      redirect_to dashboard_url
    end

  end
end

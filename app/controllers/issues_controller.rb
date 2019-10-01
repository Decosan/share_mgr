class IssuesController < ApplicationController
  def index
    @issue = Issue.new
    @issues = Issue.all.order('created_at DESC').page(params[:page])
  end

  def new
  end

  def create
    @issue = current_user.issues.build(issue_params)
    if photo = params[:issue][:photo]
      @issue.photo.attach(photo)
    end
    if @issue.save
      flash[:success] ="掲示板に投稿しました"
      redirect_to issues_path
    else
      flash[:danger] ="失敗しました"
      render 'new'
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy
    flash[:danger] ="投稿を削除しました"
    redirect_back(fallback_location: root_path)
  end

  private

  def issue_params
    params.require(:issue).permit(:body, :user_id, label_ids: [])
  end
end

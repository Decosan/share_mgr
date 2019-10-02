class IssuesController < ApplicationController
  def index
    @issue = Issue.new
    @issues = Issue.all.order('created_at DESC').page(params[:page])
    if params[:issue] && params[:issue][:search]
      @issues = Issue.joins(:issue_labels).where('issue_labels.label_id = ?', params[:issue][:label_ids]).page(params[:page])  
    end  
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
      @issues = Issue.all.order('created_at DESC').page(params[:page])
      render 'index'
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

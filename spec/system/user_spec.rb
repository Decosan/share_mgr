require 'rails_helper'

RSpec.describe "User", type: :system do
  
  describe 'User一覧' do
    context '正常系' do
      fit 'サインアップ後は個人情報登録画面へ遷移し、登録後はUser詳細画面へ遷移すること' do
        # TODO: ローカル変数ではなく let を使用してください
        visit sign_in_path
        @user1 = User.new(name:'test',email:'test@123.com',password:'123456')
        click_link 'Sign up'
        expect(current_path).to eq new_personnel_path
        FactoryBot.create(:personnel, last_name: "tester", first_name: 'suzuki', birth_date: '1999/12/31', gender: 0, room: 0, in_date: '2019/10/10', out_plan_date: '2020/10/10', user_id: @user.id)
        click_link '登録'
        expect(current_path).to eq user_path(@user.id)
      end

      it 'Project詳細から一覧ページにアクセスした場合、Taskが表示されること' do
        # FIXME: テストが失敗するので修正してください
        project = FactoryBot.create(:project)
        task = FactoryBot.create(:task, project_id: project.id)
        visit project_path(project)
        click_link 'View Todos'
        switch_to_window(windows.last)
        expect(page).to have_content task.title
        expect(Task.count).to eq 1
        expect(current_path).to eq project_tasks_path(project)
      end
    end
  end
end
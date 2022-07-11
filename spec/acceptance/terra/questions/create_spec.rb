require "feature_helper"

feature "Create question" do
  let!(:user) { create(:user) }
  describe "with correct policy", js: true do

    background do
      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit terra_questions_path
    end

    scenario "create a question" do
      # click_button "Add Question"
      expect(page).to have_content("Add Question")
      save_and_open_page
    end
    # visi_new_user_session
    # save_open_page
  end
end
require "application_system_test_case"

class HelpOptionsTest < ApplicationSystemTestCase
  setup do
    @help_option = help_options(:one)
  end

  test "visiting the index" do
    visit help_options_url
    assert_selector "h1", text: "Help Options"
  end

  test "creating a Help option" do
    visit help_options_url
    click_on "New Help Option"

    fill_in "Descriptioncall", with: @help_option.descriptioncall
    fill_in "Descriptionvol", with: @help_option.descriptionvol
    click_on "Create Help option"

    assert_text "Help option was successfully created"
    click_on "Back"
  end

  test "updating a Help option" do
    visit help_options_url
    click_on "Edit", match: :first

    fill_in "Descriptioncall", with: @help_option.descriptioncall
    fill_in "Descriptionvol", with: @help_option.descriptionvol
    click_on "Update Help option"

    assert_text "Help option was successfully updated"
    click_on "Back"
  end

  test "destroying a Help option" do
    visit help_options_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Help option was successfully destroyed"
  end
end

require "application_system_test_case"

class CallsTest < ApplicationSystemTestCase
  setup do
    @call = calls(:one)
  end

  test "visiting the index" do
    visit calls_url
    assert_selector "h1", text: "Calls"
  end

  test "creating a Call" do
    visit calls_url
    click_on "New Call"

    fill_in "Address", with: @call.address
    fill_in "City", with: @call.city_id
    fill_in "Description", with: @call.description
    fill_in "Email", with: @call.email
    check "Healthcheck" if @call.healthcheck
    fill_in "Lastname", with: @call.lastname
    fill_in "Name", with: @call.name
    fill_in "Phone", with: @call.phone
    fill_in "User", with: @call.user_id
    click_on "Create Call"

    assert_text "Call was successfully created"
    click_on "Back"
  end

  test "updating a Call" do
    visit calls_url
    click_on "Edit", match: :first

    fill_in "Address", with: @call.address
    fill_in "City", with: @call.city_id
    fill_in "Description", with: @call.description
    fill_in "Email", with: @call.email
    check "Healthcheck" if @call.healthcheck
    fill_in "Lastname", with: @call.lastname
    fill_in "Name", with: @call.name
    fill_in "Phone", with: @call.phone
    fill_in "User", with: @call.user_id
    click_on "Update Call"

    assert_text "Call was successfully updated"
    click_on "Back"
  end

  test "destroying a Call" do
    visit calls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Call was successfully destroyed"
  end
end

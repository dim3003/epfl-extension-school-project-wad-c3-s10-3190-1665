require "application_system_test_case"

class NavigationTestsTest < ApplicationSystemTestCase

  test 'navigation test' do
    visit('/')
    expect(page).to have_selector(:link_or_button, 'Pin')
    expect(page).to have_selector(:link_or_button, 'All Pins')
    expect(page).to have_selector(:link_or_button, 'Sign Up / Log in')
    expect(page).to have_selector(:link_or_button, 'About')

    click_on('All Pins', match: :first)
    expect(page).to have_selector(:link_or_button, 'Pin')
    expect(page).to have_selector(:link_or_button, 'All Pins')
    expect(page).to have_selector(:link_or_button, 'Sign Up / Log in')
    expect(page).to have_selector(:link_or_button, 'About')
  end



end

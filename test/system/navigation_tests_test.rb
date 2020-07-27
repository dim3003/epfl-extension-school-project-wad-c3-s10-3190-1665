require "application_system_test_case"

class NavigationTestsTest < ApplicationSystemTestCase

  test 'search term is displayed' do
    visit('/')
    assert page.has_content?('Pin')
    fill_in('q', with: 'Spain').send_keys(:enter)
    assert has_content?('Spain')
    assert current_url.include?('q=Spain')
  end



end

require "application_system_test_case"

class NavigationTestsTest < ApplicationSystemTestCase

  test 'navigation test not logged in' do
    visit('/')
    assert page.has_selector?(:link_or_button, 'Pin')
    assert page.has_selector?(:link_or_button, 'All Pins')
    assert page.has_selector?(:link_or_button, 'Sign up / Login')
    assert page.has_selector?(:link_or_button, 'About')

    visit(pins_path)
    assert page.has_selector?(:link_or_button, 'Pin')
    assert page.has_selector?(:link_or_button, 'All Pins')
    assert page.has_selector?(:link_or_button, 'Sign up / Login')
    assert page.has_selector?(:link_or_button, 'About')

    visit(new_user_path)
    assert page.has_selector?(:link_or_button, 'Pin')
    assert page.has_selector?(:link_or_button, 'All Pins')
    assert page.has_selector?(:link_or_button, 'Sign up / Login')
    assert page.has_selector?(:link_or_button, 'About')
    end

    test 'navigation test logged in' do

      user = User.new email: 'an@email.com'
      user.save!
      visit(new_user_path)
      fill_in('Email address', with: user.email)
      click_on('Log in', match: :first)

      visit('/')
      assert page.has_selector?(:link_or_button, 'Pin')
      assert page.has_selector?(:link_or_button, 'All Pins')
      assert page.has_selector?(:link_or_button, 'My Pins')
      assert page.has_selector?(:link_or_button, 'About')

      visit(pins_path)
      assert page.has_selector?(:link_or_button, 'Pin')
      assert page.has_selector?(:link_or_button, 'All Pins')
      assert page.has_selector?(:link_or_button, 'My Pins')
      assert page.has_selector?(:link_or_button, 'About')

      end

end

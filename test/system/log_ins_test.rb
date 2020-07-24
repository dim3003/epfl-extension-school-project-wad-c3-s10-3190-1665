require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase

  test 'sign up and creates a User' do
      visit(new_user_path)
      fill_in('Email', with: 'abogus@epfl.ch')
      click_on('Log in', match: :first)
      assert_equal 1, User.all.length
      assert_equal 'abogus@epfl.ch', User.first.email
  end

  test 'log in does not create a user' do
    user = User.new email: 'abogus@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in', match: :first)
    assert_equal 1, User.all.length
  end

  test 'can create pin only when logged in' do
    visit(pins_path)
    refute page.has_content?('Create a new Pin')
    user = User.new email: 'abogus@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(pins_path)
    sleep(10.seconds)
    assert page.has_content?('Create a new Pin')
  end
end

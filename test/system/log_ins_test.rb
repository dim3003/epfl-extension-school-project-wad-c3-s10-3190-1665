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
    assert page.has_content?('Create a new Pin')
  end

  test 'sign up / login link only available when logged in' do
    visit('/')
    assert page.has_content?('Sign up / Login')
    user = User.new email: 'abogus@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit('/')
    refute page.has_content?('Sign up / Log in')
  end

  test 'My Pins link only available when logged in' do
    visit('/')
    refute page.has_content?('My Pins')
    user = User.new email: 'abogus@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit('/')
    assert page.has_content?('My Pins')
  end

  test 'can only edit or add pins when logged in' do
    pin = Pin.new title: 'New Pin',
                  user: User.new
    pin.save!
    visit(pin_path(pin))
    refute page.has_content?('Edit Pin')
    refute page.has_content?('Add Pin')
    user = User.new email: 'abogus@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(pin_path(pin))
    assert page.has_content?('Edit Pin')
    assert page.has_content?('Add to My Pins')
  end
end

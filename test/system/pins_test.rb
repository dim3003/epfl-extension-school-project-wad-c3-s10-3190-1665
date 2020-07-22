require "application_system_test_case"

class PinsTest < ApplicationSystemTestCase

  test 'create new pin' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(new_pin_path)
    fill_in('Title', with: 'Test pin')
    fill_in('Image url', with: 'https://www.gettyimages.co.uk/gi-resources/images/RoyaltyFree/Apr17Update/ColourSurge1.jpg')
    fill_in('Tag', with: 'test tag')
    click_on('Create pin', match: :first)
    assert page.has_content?('Test pin')
  end

  test 'index loads pins' do
    pin_1 = pin.new title: 'Join a tennis club',
                      user: User.new
    pin_1.save!

    pin_2 = pin.new title: 'Start a blog',
                      user: User.new
    pin_2.save!

    visit(pins_path)
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end

end

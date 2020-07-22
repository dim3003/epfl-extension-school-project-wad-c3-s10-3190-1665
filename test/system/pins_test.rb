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
    pin_1 = Pin.new title: 'Join a tennis club',
                      user: User.new
    pin_1.save!

    pin_2 = Pin.new title: 'Start a blog',
                      user: User.new
    pin_2.save!

    visit(pins_path)
    assert page.has_content?('Join a tennis club')
    assert page.has_content?('Start a blog')
  end

  test 'search' do
    pin_1 = Pin.new title: 'Climb Mont Blanc',
                      user: User.new
    pin_1.save!
    pin_2 = Pin.new title: 'Visit Niagara Falls',
                      user: User.new
    pin_2.save!

    visit('/')
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)

    assert current_path.include?(pins_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagara Falls')
  end

  test 'search no pin found' do
    visit(pins_path)
    assert page.has_content?('No pin found')
  end

  test 'check homepage pins' do
    3.times do |i|
      pin = Pin.new title: "Exciting new pin #{i+1}",
                      user: User.new
      pin.save!
    end

    visit('/')

    assert page.has_content?('Exciting new pin 1')
    assert page.has_content?('Exciting new pin 2')
    assert page.has_content?('Exciting new pin 3')

    refute page.has_content?('Exciting new pin 4')
  end

end

require "application_system_test_case"

class PinsTest < ApplicationSystemTestCase

  test 'check homepage pins' do
    6.times do |i|
      pin = Pin.new title: "Exciting new pin #{i+1}",
                      user: User.new
      pin.save!
    end

    visit('/')

    assert page.has_content?('Exciting new pin 1')
    assert page.has_content?('Exciting new pin 2')
    assert page.has_content?('Exciting new pin 3')
    assert page.has_content?('Exciting new pin 4')
    assert page.has_content?('Exciting new pin 5')
    assert page.has_content?('Exciting new pin 6')

    refute page.has_content?('Exciting new pin 7')
  end

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
    click_on('Create Pin', match: :first)
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

  test 'edit pin test' do
    user = User.new email: 'an@email.com'
    user.save!
    pin = Pin.new title: 'edit pin test',
                  user: User.new
    pin.save!
    visit(edit_pin_path(pin))
    fill_in('Title', with: 'Climb Bishorn')
    fill_in('Tag', with: 'mountain')
    click_on('Update', match: :first)
    click_on('Climb Bishorn', match: :first)
    assert page.has_content?('Climb Bishorn')
    assert page.has_content?('mountain')
  end

  test 'search' do
    pin_1 = Pin.new title: 'Mont Blanc',
                      user: User.new
    pin_1.save!
    pin_2 = Pin.new title: 'Niagara Falls',
                      user: User.new
    pin_2.save!

    visit('/')
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)

    assert current_path.include?(pins_path)
    assert page.has_content?('Mont Blanc')
    refute page.has_content?('Niagara Falls')
  end

  test 'search no pin found' do
    visit(pins_path)
    assert page.has_content?('No pin found')
  end

  test 'search tag test' do
    pin_1 = Pin.new title: 'Europe cycling',
                    user: User.new,
                    tag: 'cycling'
    pin_1.save!
    pin_2 = Pin.new title: 'Provence',
                    tag: 'France cycling',
                    user: User.new
    pin_2.save!
    pin_3 = Pin.new title: 'Kitty',
                    tag: 'cat',
                    user: User.new
    pin_3.save!

    visit('/')
    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)

    assert page.has_content?('Europe cycling')
    assert page.has_content?('Provence')
    refute page.has_content?('Kitty')
  end

  test 'validation test for creating pins tag too long' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(new_pin_path)
    fill_in('Title', with: 'Test Pin')
    fill_in('Tag', with: 'a tag which is too long to be validated because it has to be max 30 characters')
    click_on('Create Pin', match: :first)

    assert page.has_content?('Tag is too long (maximum is 30 characters)')
  end

  test 'validation test for creating pins no title' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(new_pin_path)
    click_on('Create Pin', match: :first)

    assert page.has_content?("Title can't be blank")
  end

  test 'validation test for creating pins no title and tag too long' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(new_pin_path)
    fill_in('Tag', with: 'a tag which is too long to be validated because it has to be max 30 characters')
    click_on('Create Pin', match: :first)

    assert page.has_content?("Title can't be blank")
    assert page.has_content?('Tag is too long (maximum is 30 characters)')
  end

  test 'validation test for editing pins tag too long' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(edit_pin_path)
    fill_in('Title', with: 'Test Pin')
    fill_in('Tag', with: 'a tag which is too long to be validated because it has to be max 30 characters')
    click_on('Update Pin', match: :first)

    assert page.has_content?('Tag is too long (maximum is 30 characters)')
  end

  test 'validation test for editing pins no title' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(edit_pin_path)
    click_on('Update Pin', match: :first)

    assert page.has_content?("Title can't be blank")
  end

  test 'validation test for editing pins no title and tag too long' do
    user = User.new email: 'an@email.com'
    user.save!
    visit(new_user_path)
    fill_in('Email address', with: user.email)
    click_on('Log in', match: :first)
    visit(edit_pin_path)
    fill_in('Tag', with: 'a tag which is too long to be validated because it has to be max 30 characters')
    click_on('Update Pin', match: :first)

    assert page.has_content?("Title can't be blank")
    assert page.has_content?('Tag is too long (maximum is 30 characters)')
  end


end

require 'test_helper'

class PinTest < ActiveSupport::TestCase
  test 'the first empty Pin created is first in the list' do
    first_pin = Pin.new title: 'first_pin',
                        user: User.new
    first_pin.save!
    second_pin = Pin.new title: 'Second_pin',
                         user: User.new
    second_pin.save!
    assert_equal(first_pin, Pin.all.first)
  end

  test 'the first complete Pin created is first in the list' do
    first_pin = Pin.new title: 'Cycle the length of the United Kingdom',
                          image_url: '',
                          tag: 'cycling',
                          user: User.new
    first_pin.save!
    second_pin = Pin.new title: 'Visit Japan',
                           image_url: 'https://upload.wikimedia.org/wikipedia/commons/8/86/Solid_grey.svg',
                           tag: 'Japan',
                           user: User.new
    second_pin.save!
    assert_equal(first_pin, Pin.all.first)
  end

  test 'updated_at is changed after updating title' do
    pin = Pin.new title: 'Visit Marrakech',
                    user: User.new
    pin.save!
    first_updated_at = pin.updated_at
    pin.title = 'Visit the market in Marrakech'
    pin.save!
    refute_equal(pin.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating tag' do
    pin = Pin.new title: 'updated at test',
                    user: User.new
    pin.tag = 'tag'
    pin.save!
    first_updated_at = pin.updated_at
    pin.tag = 'tag edit'
    pin.save!
    refute_equal(pin.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating image_url' do
    pin = Pin.new title: 'updated_at pin',
                  image_url: 'https://upload.wikimedia.org/wikipedia/commons/8/86/Solid_grey.svg',
                  user: User.new
    pin.save!
    first_updated_at = pin.updated_at
    pin.image_url = 'http://data.freehdw.com/bunny-rabbit-cute-free-desktop.jpg'
    pin.save!
    refute_equal(pin.updated_at, first_updated_at)
  end

  test 'search' do
    pin = Pin.new title:'Stand at the top of the Empire State Building',
                  user: User.new
    pin.save!
    assert_equal Pin.search('the top').length, 1
  end

  test 'search no matching' do
    pin = Pin.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    pin.save!
    assert_empty Pin.search('snorkelling')
  end

  test 'search two matching' do
    pin_1 = Pin.new title: 'Stand at the top of the Empire State Building',
                      user: User.new
    pin_1.save!
    pin_2 = Pin.new title: 'Stand on the pyramids',
                      user: User.new
    pin_2.save!
    assert_equal Pin.search('Stand').length, 2
  end

  test 'most_recent no pin' do
    assert_empty Pin.most_recent
  end

  test 'most_recent 2 pins' do
    pin_1 = Pin.new title: 'Stand at the top of the Empire State Building',
                      user: User.new
    pin_1.save!
    pin_2 = Pin.new title: 'Stand on the pyramids',
                      user: User.new
    pin_2.save!

    assert_equal Pin.most_recent.length, 2
    assert_equal Pin.most_recent.first, pin_2
  end

  test 'most_recent 6 pins' do
    pins = Array.new
    10.times do |i|
      pin = Pin.new title: "Exciting new pin #{i+1}",
                      user: User.new
      pin.save!
      pins.push(pin)
    end
    assert_equal Pin.most_recent.length, 6
    assert_equal Pin.most_recent.first, pins[9]
  end

  test 'search with tag' do
    pin = Pin.new title: 'Surfing in Portugal',
                  user: User.new,
                  tag: 'coast'
    pin.save!

    assert_equal Pin.search('coast').length, 1
  end

  test 'search with tag and title' do
    pin_1 = Pin.new title: 'See',
                    tag: 'Stay',
                    user: User.new
    pin_1.save!
    pin_2 = Pin.new title: 'Hike the mountains in Italy',
                    tag: 'See',
                    user: User.new
    pin_2.save!

    assert_equal Pin.search('See').length, 2
  end

  test 'title validation with no title attribute' do
    pin = Pin.new user: User.new
    refute pin.valid?
  end

  test 'tag validation' do
    pin = Pin.new title: 'a title',
                  tag: 'A tag too long which should not pass the validation test we put in place grrrrrrrrrrrrrrrrrrrrrrrrr!',
                  user: User.new
    refute pin.valid?
  end

end

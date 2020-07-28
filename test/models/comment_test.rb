require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'changing the associated Pin for a Comment' do
      pin = Pin.new title: 'a valid title',
                    user: User.new
      pin.save!
      comment = Comment.new body: "I'd like to do this!",
                            pin: pin,
                            user: User.new
      pin_2 = Pin.new title: 'another valid title',
                      user: User.new
      pin_2.save!
      comment.pin = pin_2
      comment.save!

      assert_equal Comment.first.pin, pin_2
    end

    test 'cascading save' do
      pin = Pin.new title: 'a valid title',
                    user: User.new
      pin.save
      comment = Comment.new body: "Great pin!",
                user: User.new
      pin.comments << comment
      pin.save
      assert_equal Comment.first, comment
    end

    test 'Comments are ordered properly' do
      pin = Pin.new title: 'a valid title',
                    user: User.new
      pin.save!

      comment = Comment.new body: "This would be great fun",
                            user: User.new
      comment_2 = Comment.new body: "I agree! I's like to do this as well",
                              user: User.new

      pin.comments << comment
      pin.comments << comment_2
      pin.save

      assert_equal Comment.first, comment
      assert_equal 2, pin.comments.length
    end
end

require 'rails_helper'

RSpec.describe Post, type: :model do
    before(:example) do
        @first_user = User.new(Name: 'Tom', Photo:'https://unsplash.com/photos/F_-0BxGuVvo', Bio: 'Teacher from Mexico' )
    end

    subject { Post.new(author_id: @first_user.id, title: 'Hello', text: 'This is my first post') }
    it 'title should be present' do
        subject.title = nil
        expect(subject).to_not be_valid
      end
   
      it 'LikesCounter must be an integer greater than or equal to zero.' do
        subject.likes_counter = -1
        expect(subject).to_not be_valid
      end

    it 'comments counter should be greater than or equal to zero' do
        subject.comments_counter = -1
        expect(subject).to_not be_valid
      end

      it 'Title must not exceed 250 characters' do
        expect(subject.title.length).to be <= 250
      end

end
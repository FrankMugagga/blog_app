RSpec.describe Like, type: :model do
  describe 'validation' do
    subject { Like.new }

    before { subject.save }

    it 'likes text should contain text' do
      expect(subject).to_not be_valid
    end
  end

  describe '#update_like_counter' do
  user = User.create(Name: 'Lumbuye', posts_counter: 2)

    post = user.posts.create(title: 'Post2', text: 'content 2', comments_counter: 2, likes_counter: 2)

  it 'updates the likes_counter of the associated post' do
    like = Like.create(author_id: user.id, post_id: post.id)

    expect { like.send(:update_like_counter) }.to change { post.reload.likes_counter }.by(1)
  end
end
end

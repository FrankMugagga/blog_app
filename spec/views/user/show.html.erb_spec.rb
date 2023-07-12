RSpec.describe 'User', type: :view do
  include Capybara::DSL
  before do
    @user = User.create(Name: 'Jot', Photo: 'john.png', Bio: 'from Hungary', posts_counter: 1)
    @user1 = User.create(Name: 'Johnt', Photo: 'john.png', Bio: 'from Hungary', posts_counter: 1)
    @user2 = User.create(Name: 'Dee', Photo: 'dee.png', Bio: 'uganda', posts_counter: 2)
    @post1 = @user1.posts.create(text: 'Post 1', comments_counter: 0, likes_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Test Post', text: 'text body', comments_counter: 1,
                        likes_counter: 1)
  end

  describe 'user show page' do
    before do
      visit user_path(@user1.id)
      visit user_path(@user2.id)
    end

    it "Should see the user's profile picture" do
      page.has_content?(@user1.Photo)
      page.has_css?('.img-fluid')
      expect(page).to have_css("img[src*='dee']")
    end

    it "I can see the user's username" do
      page.has_content?(@user1.Name)
      expect(page).to have_content(@user2.Name)
    end

    it 'I can see the number of posts the user has written.' do
      page.has_content?("Number of posts: #{@user1.posts_counter}")
      expect(page).to have_content(@user2.posts_counter)
    end

    it "I can see the user's bio." do
      page.has_css?('user_bio')
      if @user2.Bio.present?
        expect(page).to have_content(@user2.Bio)
      else
        page.has_content?('No Bio entered')
      end
    end

    it "I can see the user's first 3 posts." do
      @user1.recent_posts.limit(3).each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it "I can see a button that lets me view all of a user's posts." do
      expect(page).to have_link('See more posts', href: user_posts_path(@user2))
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      visit user_posts_path(@user)
      click_on 'text body'
      visit user_post_path(@user.id, @post.id)
      page.has_content?(@post.title)
    end

    it "When I click to see all posts, it redirects me to the user's post's index page." do
      click_link 'See more posts'
      expect(page).to have_current_path(user_posts_path(@user2))
    end
  end
end

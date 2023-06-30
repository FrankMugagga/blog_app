RSpec.describe User, type: :model do
  
  let(:user) { User.new(Name: 'John', posts_counter: 0) }

  it 'Name should not be null' do
    subject.Name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter should be greater than or equal to zero' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'is not valid when posts_counter is not an integer' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end


  it 'is not valid with a non-integer posts_counter' do
    user.posts_counter = 1.5
    expect(user).not_to be_valid
    expect(user.errors[:posts_counter]).to include("must be an integer")
  end

  
end

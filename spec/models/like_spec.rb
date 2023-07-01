RSpec.describe Like, type: :model do
  describe 'validation' do
    subject { Like.new }

    before { subject.save }

    it 'likes text should contain text' do
      expect(subject).to_not be_valid
    end
  end
end

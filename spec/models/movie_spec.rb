require 'spec_helper'

describe Movie do
  describe 'searching for movies by director' do
    it 'should call find with director keyword' do
      Movie.should_receive(:where)
        .with(hash_including :director => 'Ridley Scott')
      Movie.find_similar('Ridley Scott')
    end
  end
end

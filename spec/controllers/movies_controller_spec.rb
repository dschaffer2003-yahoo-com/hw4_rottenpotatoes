require 'spec_helper'

describe MoviesController do
  describe 'finding movies by the same director' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call the model method that searches for movies by the same director' do
      Movie.should_receive(:find_similar).with('Ridley Scott').
        and_return(@fake_results)
      post :similar, {:director => 'Ridley Scott'}
    end

    describe 'after valid search' do
      before :each do
        Movie.stub(:find_similar).and_return(@fake_results)
        post :similar, {:director => 'Ridley Scott'}
      end
      it 'should select the Same Director template for rendering' do
        response.should render_template('similar')
      end

      it 'should make the search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
end

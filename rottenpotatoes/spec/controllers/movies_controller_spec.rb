require 'rails_helper'
describe MoviesController, :type => :controller do
  
  describe 'create a new movie' do
    it 'should create a new movie and redirect' do
      post :create, {:movie => {:title => "A", :rating => "R", :description => "XYZ", :release_date => "01/01/2021", :director => "ABC"}}
      expect(flash[:notice]).to be_present
      response.should redirect_to movies_path
    end
  end
  
  describe 'find movies with same director' do
    
    it 'should call the method to find movies with same director' do
      Movie.should_receive(:find_with_same_director).with("1")
      get :similar, {:id => 1}
    end
    
    it 'should render similar template when movie has a director' do
      Movie.stub(:find_with_same_director).and_return(nil, nil, false)
      get :similar, {:id => 1}
      response.should render_template('similar')
    end
    
    it 'should make movies with same director available to that template' do
      movie = double('Movie')
      results = [double('Movie'), double('Movie')]
      Movie.stub(:find_with_same_director).and_return([movie, results, false])
      get :similar, {:id => 1}
      assigns(:movie).should == movie
      assigns(:movies).should == results
    end
    
    it 'should select the page to redirect to when movie has no director' do
      movie = double('Movie', :title => 'ABC')
      Movie.stub(:find_with_same_director).and_return([movie, nil, true])
      get :similar, {:id => 1}
      response.should redirect_to movies_path
    end
    
    it 'should make the error message available' do
      movie = double('Movie', :title => 'ABC')
      Movie.stub(:find_with_same_director).and_return([movie, nil, true])
      get :similar, {:id => 1}
      expect(flash[:notice]).to be_present
    end
  end
end 
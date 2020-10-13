require 'rails_helper'
describe MoviesHelper do
    describe 'check a number if it is odd or even' do
        it 'should return odd' do
            response = oddness(1)
            expect(response).to eq("odd")
        end
        it 'should return even' do
            response = oddness(2)
            expect(response).to eq("even")
        end
    end
end
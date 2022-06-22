require 'rails_helper'

describe 'Rentals API', focus: true do
  let(:api_user) { create(:user) }
  let(:other_api_user) { create(:user) }

  describe 'GET #index'  do
    it 'should require a valid api_user' do
      get '/api/rentals', xhr: true

      expect(response.status).to eq 422
    end

    context 'when authenticated as api_user' do
      before do
        5.times { |_i| create(:rental, owner: api_user) }
        login_as api_user
      end

      it 'should list all rentals owned by the api_user' do
        get "/api/rentals?api_key=#{api_user.api_key}", xhr: true

        expect(response.status).to eql(200)
        expect(JSON.parse(response.body).size).to eql(5)
      end

      it 'should not list rentals that are not owned by the other_api_user' do
        api_user.rentals.last.update(owner: other_api_user)
        get "/api/rentals?api_key=#{api_user.api_key}", xhr: true

        expect(response.status).to eql(200)
        expect(JSON.parse(response.body).size).to eql(4)
      end
    end
  end

  describe 'GET #show'  do
    let(:rental) { create(:rental) }
    let!(:rental_owner) { rental.owner }

    it 'should require a valid api_user' do
      get '/api/rentals', xhr: true

      expect(response.status).to eq 422
    end

    context 'when authenticated as api_user' do
      it 'should show rental owned by the api_user' do
        get "/api/rentals/#{rental.id}?api_key=#{rental_owner.api_key}", xhr: true

        expect(response.status).to eql(200)
      end

      it 'should not show rental that is owned by the other_api_user' do
        rental.update!(owner: other_api_user)
        expect(api_user.reload.rentals.size).to eql(0)
        expect(other_api_user.reload.rentals.size).to eql(1)

        get "/api/rentals/#{rental.id}?api_key=#{rental_owner.api_key}", xhr: true
        expect(response.status).to be 422
      end
    end
  end

  describe 'POST #create' do
    it 'should require a valid api_user' do
      post '/api/rentals'
      expect(response).to have_http_status(422)
    end

    context 'when authenticated as api_user' do
      before do
        login_as api_user
      end

      it 'creates new rental' do
        post "/api/rentals?api_key=#{api_user.api_key}", xhr: true, params: {
         title: 'new rental test', city: 'dallas', location: 'dallas, tx 123 muffin lane',
         category: 'two_bedroom', bedrooms: 2, description: 'great deal', street_address: '123 muffin ln'
        }

        expect(response.status).to eql(200)
        expect(api_user.reload.rentals.size).to eql(1)
        expect(other_api_user.reload.rentals.size).to eql(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:rental) { create(:rental) }
    let!(:rental_owner) { rental.owner }

    it 'should require a valid api_user' do
      get '/api/rentals', xhr: true
      expect(response.status).to eq 422
    end

    context 'when authenticated as api_user' do
      before do
        login_as api_user
      end

      it 'should delete a rental owned by the api_user' do
        rental.update!(owner: api_user)
        expect(api_user.reload.rentals.size).to eql(1)

        delete "/api/rentals/#{rental.id}?api_key=#{api_user.api_key}", xhr: true
        expect(response.status).to be 200
        expect(api_user.reload.rentals.size).to eql(0)
      end

      it 'should not delete a rental that is not owned by the api_user' do
        rental.update!(owner: other_api_user)
        expect(api_user.reload.rentals.size).to eql(0)
        expect(other_api_user.reload.rentals.size).to eql(1)

        delete "/api/rentals/#{rental.id}?api_key=#{api_user.api_key}", xhr: true
        expect(response.status).to be 422
        expect(other_api_user.reload.rentals.size).to eql(1)
      end
    end
  end
end
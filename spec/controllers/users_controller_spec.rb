require 'rails_helper'

RSpec.describe UsersController do
  describe '#create' do
    let!(:dummy_user) {
      {
        name: 'dummy',
        nickname: 'dummy_nick',
        email: 'dummy@example.com',
        password: 'password'
      }
    }
    context 'receive status 200' do
      it 'should be successful' do
        post :create, user: dummy_user, format: :json
        expect(response.status).to eq(200)
      end
    end

    context 'receive response in json format' do
      it 'should be successful' do
        post :create, user: dummy_user, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
        response_result = JSON.parse(response.body)
        expect(response_result).to_not be_nil
        expect(response_result['message']).to eq('Successfully created a user')
        expect(response_result['data']).to include('name' => 'dummy')
      end
    end

    context 'send valida params ' do
      it 'should receive single user' do
        post :create, user: dummy_user, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data']).to include({ 'name' => 'dummy' })
        expect(response_result['data']).to include({ 'nickname' => 'dummy_nick' })
        expect(response_result['data']).to include({ 'email' => 'dummy@example.com' })
      end
    end

    context 'send invalid name' do
      it 'should receive an error' do
        dummy_user = {
          name: nil,
          nickname: 'dummy_nick',
          email: 'dummy@example.com',
          password: 'password'
        }
        post :create, user: dummy_user, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['message']).to eq('Failed to create a user')
        expect(response_result['data']['name'][0]).to eq('can\'t be blank')
      end
    end
    context 'send invalid params' do
      it 'should receive an error' do
        dummy_user = {
          name: nil,
          nickname: nil,
          email: nil,
          password: nil
        }
        post :create, user: dummy_user, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['message']).to eq('Failed to create a user')
        expect(response_result['data']['name'][0]).to eq('can\'t be blank')
      end
    end
    context 'send blank params' do
      it 'should receive an error' do
        dummy_user = {}
        post :create, user: dummy_user, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['message']).to eq('Failed to create a user due to missing params')
        expect(response_result['data']).to eq([])
      end
    end
  end
end

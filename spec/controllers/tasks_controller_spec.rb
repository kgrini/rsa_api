require 'rails_helper'

RSpec.describe TasksController do
  let(:auth_headers) {
    user = FactoryGirl.create(:user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.headers.merge! user.create_new_auth_token
  }
  describe '#create' do
    let(:task) {
      {
        tag: 'ABC',
        deadline_time: DateTime.now
      }
    }
    context 'receive status 200' do
      it 'should be successful' do
        auth_headers
        post :create, format: :json
        expect(response.status).to eq(200)
      end
    end

    context 'receive response in json format' do
      it 'should be successful' do
        auth_headers
        post :create, task: task, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result).to_not be_nil
      end
    end

    context 'send valid params ' do
      it 'should receive single user' do
        auth_headers
        post :create, task: task, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data']['tag']).to eq(task[:tag])
      end
    end

    context 'send blank params' do
      it 'should receive an error' do
        post :create, task: {}, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['status']).to eq('failed')
        expect(response_result['data']).to eq([])
      end
    end
  end
end

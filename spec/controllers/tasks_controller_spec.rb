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

    context 'send valid params' do
      it 'should receive single record' do
        auth_headers
        post :create, task: task, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data']['tag']).to eq(task[:tag])
        expect(response_result['data']['status']).to eq('new')
      end
    end

    context 'send blank params' do
      it 'should receive an error' do
        auth_headers
        post :create, task: {}, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['status']).to eq('failed')
        expect(response_result['data']).to eq([])
      end
    end
  end

  describe '#close' do
    let(:task) {
      FactoryGirl.create(:task, user: create(:user))
    }

    context 'receive status 200' do
      it 'should be successful' do
        auth_headers
        put :close, id: task.id, format: :json
        expect(response.status).to eq(200)
      end
    end

    context 'receive response in json format' do
      it 'should be successful' do
        auth_headers
        put :close, id: task.id, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result).to_not be_nil
      end
    end

    context 'send valid id' do
      it 'should receive single record' do
        auth_headers
        put :close, id: task.id, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data']['tag']).to eq(task[:tag])
        expect(response_result['data']['status']).to eq('done')
      end
    end

    context 'send without id' do
      it 'should receive an error' do
        auth_headers
        put :close, id: '', format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['status']).to eq('failed')
      end
    end
  end

  describe '#list' do
    context 'receive status 200' do
      it 'should be successful' do
        auth_headers
        get :list, format: :json
        expect(response.status).to eq(200)
      end
    end

    context 'receive response in json format' do
      it 'should be successful' do
        auth_headers
        get :list, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result).to_not be_nil
      end
    end

    context 'receive tasks' do
      it 'should return a list' do
        auth_headers
        create_list(:task, 4, user: create(:user))
        get :list, tag: Task.first.tag, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(4)
      end
    end

    context 'receive task with status done and similar tag' do
      it 'should return a list' do
        auth_headers
        create_list(:task, 4, user: create(:user))

        Task.first.update_attribute(
          :status,
          'done'
        )

        get :list, tag: Task.first.tag,status: 'done', format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(1)
      end
    end

    context 'receive task with status done and different tag' do
      it 'should return a list' do
        auth_headers
        create_list(:task, 4, user: create(:user))

        Task.first.update_attributes(
          status:'done',
          tag: 'DEF'
        )

        get :list, tag: Task.last.tag, status: 'done', format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(0)
      end
    end

    context 'receive tasks with status new' do
      it 'should return a list by default' do
        auth_headers
        create_list(:task, 4, user: create(:user))

        Task.first.update_attribute(
          :status,
          'done'
        )

        get :list, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(3)
      end
    end

    context 'receive tasks by tag' do
      it 'should return a list by default' do
        auth_headers
        create_list(:task, 4, user: create(:user))

        Task.first.update_attributes(
          status:'done',
          tag: 'DEF'
        )

        get :list, tag: Task.last.tag, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(3)
      end
    end

    context 'receive tasks by tag' do
      it 'should return a list by default' do
        auth_headers
        create_list(:task, 4, user: create(:user))

        Task.first.update_attributes(
          status:'done'
        )

        Task.second.update_attributes(
          status:'done',
          tag: 'DEF'
        )

        get :list, tag: Task.last.tag, format: :json
        response_result = JSON.parse(response.body)
        expect(response_result['data'].length).to eq(2)
      end
    end
  end
end

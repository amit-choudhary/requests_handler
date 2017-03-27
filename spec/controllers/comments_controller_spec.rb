require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    login_customer
    let!(:request) { FactoryGirl.create(:request, customer: controller.current_user) }

    context 'when comment is created successfully' do
      before do
        post :create, params: { content: 'test content', user_id: controller.current_user.id, request_id: request.id }
      end

      it 'returns expected json' do
        expect(response.body).to eq({
          name: controller.current_user.name,
          content: 'test content'
        }.to_json)
      end

      it 'returns 200 as response code' do
        expect(response.status).to eq(200)
      end
    end

    context 'when comment is not created successfully' do
      before do
        post :create, params: { content: '', user_id: controller.current_user.id, request_id: request.id }
      end

      it 'returns expected json' do
        expect(response.body).to eq({
          message: 'Failed'
        }.to_json)
      end

      it 'returns 422 as response code' do
        expect(response.status).to eq(422)
      end
    end
  end
end

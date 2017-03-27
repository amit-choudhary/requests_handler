require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  describe 'GET #index' do

    context 'when user is customer' do
      login_customer

      let!(:first_request) { FactoryGirl.create(:request, customer: controller.current_user) }
      let!(:second_request) { FactoryGirl.create(:request) }

      before do
        get :index
      end

      it 'loads requests of customer only' do
        expect(controller.instance_variable_get('@requests').to_a).to eq([first_request])
      end

      it 'does not load requests of customer' do
        expect(controller.instance_variable_get('@requests').to_a).not_to include(second_request)
      end

      it 'returns 200 as response code' do
        expect(response.status).to eq(200)
      end

      it 'render index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is support agent' do
      login_support_agent

      let!(:first_request) { FactoryGirl.create(:request, support_agent: controller.current_user) }
      let!(:second_request) { FactoryGirl.create(:request) }

      before do
        get :index
      end

      it 'loads all requests' do
        expect(controller.instance_variable_get('@requests').to_a).to eq([first_request, second_request])
      end

      it 'returns 200 as response code' do
        expect(response.status).to eq(200)
      end

      it 'render index template' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #show' do
    context 'when user is customer' do
      login_customer
      context 'when customer is owner of the request' do
        let!(:request) { FactoryGirl.create(:request, customer: controller.current_user) }

        before do
          get :show, params: { id: request.id }
        end

        it 'returns 200 as response code' do
          expect(response.status).to eq(200)
        end

        it 'render show template' do
          expect(response).to render_template(:show)
        end

        it 'sets expected @request' do
          expect(controller.instance_variable_get('@request').id).to eq(request.id)
        end
      end

      context 'when customer is not the owner of the request' do
        let!(:request) { FactoryGirl.create(:request) }

        before do
          get :show, params: { id: request.id }
        end

        it 'returns 302 as response code' do
          expect(response.status).to eq(302)
        end

        it 'sets expected flash' do
          expect(flash[:alert]).to eq('Request not found')
        end

        it 'redirects to requests_path' do
          expect(response).to redirect_to(requests_path)
        end
      end
    end

    context 'when user is support agent' do
      login_support_agent
      let!(:request) { FactoryGirl.create(:request) }

      before do
        get :show, params: { id: request.id }
      end

      it 'returns 200 as response code' do
        expect(response.status).to eq(200)
      end

      it 'render show template' do
        expect(response).to render_template(:show)
      end

      it 'sets expected @request' do
        expect(controller.instance_variable_get('@request').id).to eq(request.id)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is customer' do
      login_customer

      context 'when request is saved successfully' do
        before do
          post :create, params: { request: { subject: 'test subject', content: 'test content' } }
        end

        it 'sets flash[:notice]' do
          expect(flash[:notice]).to eq('Request Submitted successfully.')
        end

        it 'redirects to requests_path' do
          expect(response).to redirect_to(requests_path)
        end

        it 'returns 302 as response code' do
          expect(response.status).to eq(302)
        end
      end

      context 'when request is not saved successfully' do
        before do
          post :create, params: { request: { subject: 'test subject', content: '' } }
        end

        it 'sets flash[:alert]' do
          expect(flash[:alert]).to eq("Content can't be blank")
        end

        it 'redirects to requests_path' do
          expect(response).to redirect_to(requests_path)
        end

        it 'returns 302 as response code' do
          expect(response.status).to eq(302)
        end
      end
    end

    context 'when user is support agent' do
      login_support_agent

      before do
        post :create, params: { request: { subject: 'test subject', content: 'test content' } }
      end

      it 'sets flash[:alert]' do
        expect(flash[:alert]).to eq('Unauthorized')
      end

      it 'redirects to requests_path' do
        expect(response).to redirect_to(requests_path)
      end

      it 'returns 302 as response code' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'PATCH #assign' do
    context 'when user is customer' do
      login_support_agent

      let!(:request) { FactoryGirl.create(:request) }

      context 'when request is assigned successfully' do
        before do
          patch :assign, params: { id: request.id }
        end

        it 'sets flash[:notice]' do
          expect(flash[:notice]).to eq('Request assigned successfully')
        end

        it 'redirects to request_path' do
          expect(response).to redirect_to(request_path(request))
        end

        it 'returns 302 as response code' do
          expect(response.status).to eq(302)
        end
      end

      context 'when request is not assigned successfully' do
        before do
          allow_any_instance_of(Request).to receive(:update) { false }
          patch :assign, params: { id: request.id }
        end

        it 'sets flash[:alert]' do
          expect(flash[:alert]).to eq("")
        end

        it 'redirects to request_path' do
          expect(response).to redirect_to(request_path(request))
        end

        it 'returns 302 as response code' do
          expect(response.status).to eq(302)
        end
      end
    end

    context 'when user is customer' do
      login_customer

      let!(:request) { FactoryGirl.create(:request) }

      before do
        patch :assign, params: { id: request.id }
      end

      it 'sets flash[:alert]' do
        expect(flash[:alert]).to eq('Request not found')
      end

      it 'redirects to requests_path' do
        expect(response).to redirect_to(requests_path)
      end

      it 'returns 302 as response code' do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'PATCH #solve' do
    login_support_agent

    let!(:request) { FactoryGirl.create(:request) }

    context 'when request is solved successfully' do
      before do
        patch :assign, params: { id: request.id }
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).to eq('Request assigned successfully')
      end

      it 'redirects to request_path' do
        expect(response).to redirect_to(request_path(request))
      end

      it 'returns 302 as response code' do
        expect(response.status).to eq(302)
      end
    end

    context 'when request is not solved successfully' do
      before do
        allow_any_instance_of(Request).to receive(:update) { false }
        patch :assign, params: { id: request.id }
      end

      it 'sets flash[:alert]' do
        expect(flash[:alert]).to eq("")
      end

      it 'redirects to request_path' do
        expect(response).to redirect_to(request_path(request))
      end

      it 'returns 302 as response code' do
        expect(response.status).to eq(302)
      end
    end
  end

end

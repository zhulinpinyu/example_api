require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

  let(:valid_attributes){
    {full_name: "John Ive",email: "john@ive.com",phone: "123456"}
  }

  let(:invalid_attributes){
    {full_name: nil, email: "john@ive.com", phone: "123456"}
  }

  let!(:customer) { Customer.create(valid_attributes) }

  describe "GET #index" do
    it "assigns all customers as @customers" do
      get :index,{ format: :json }
      expect(assigns(:customers)).to eq([customer])
    end
  end

  describe "GET #show" do
    it "assigns requested customer as @customer" do
      get :show, {id: customer.id, format: :json}
      expect(assigns(:customer)).to eq(customer)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "create a new Customer" do
        expect {
          post :create, {customer: valid_attributes, format: :json}
        }.to change(Customer, :count).by(1)
      end
      it "assigns a newly created customer as @customer" do
        post :create, {customer: valid_attributes, format: :json}
        expect(assigns(:customer)).to be_a(Customer)
        expect(assigns(:customer)).to be_persisted
      end
    end
    context "with invalid params" do
      it "assigns a newly created but unsaved customer as @customer" do
        post :create, {customer: invalid_attributes, format: :json}
        expect(assigns(:customer)).to be_a_new(Customer)
      end
      it "return unprocessable_entity status" do
        post :create, {customer: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #update" do
    context "with valid params" do
      let(:new_attributes){
        {full_name: "Jake Ma", phone: "2345897"}
      }

      it "updates the requested customer" do
        put :update,{id: customer.id, customer: new_attributes}
        customer.reload
        expect(customer.full_name).to eq("Jake Ma")
        expect(customer.phone).to eq("2345897")
      end

      it "assigns the requested customer as @customer" do
        put :update,{id: customer.id, customer: valid_attributes}
        expect(assigns(:customer)).to eq(customer)
      end
    end

    context "with invalid params" do
      it "assigns the customer as @customer" do
        put :update,{id: customer.id, customer: invalid_attributes}
        expect(assigns(:customer)).to eq(customer)
      end

      it "return unprocessable_entity status" do
        put :update, {id: customer.id, customer: invalid_attributes}
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #destroy" do
    it "destroys the requested customer" do
      expect {
        delete :destroy, {id: customer.id, format: :json}
      }.to change(Customer,:count).by(-1)
    end

    it "redirects to customers list" do
      delete :destroy, {id: customer.id, format: :json}
      expect(response.status).to eq(204)
    end
  end

end

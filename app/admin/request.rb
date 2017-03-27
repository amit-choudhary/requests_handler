ActiveAdmin.register Request do

  permit_params :customer_id, :support_agent_id, :subject, :content, :status

  index do
    column :id
    column :subject
    column :status
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Request Details" do
      f.input :customer, collection: Customer.order(:email).all.map{ |cus| [cus.email, cus.id] }, include_blank: false
      f.input :support_agent, collection: SupportAgent.order(:email).all.map{ |sa| [sa.email, sa.id] }
      f.input :subject
      f.input :content
      f.input :status
    end
    f.actions
  end

end

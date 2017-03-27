ActiveAdmin.register Comment do

  permit_params :user_id, :request_id, :content

  form do |f|
    f.inputs "Comment Details" do
      f.input :user, collection: User.order(:email).all.map{ |cat| [cat.email, cat.id] }, include_blank: false
      f.input :request, collection: Request.order(:subject).all.map{ |cat| [cat.subject, cat.id] }, include_blank: false
      f.input :content
    end
    f.actions
  end


end

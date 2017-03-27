class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :status, default: 0
      t.integer :customer_id
      t.integer :support_agent_id
      t.text :subject, null: false
      t.text :content, null: false
    end
  end
end

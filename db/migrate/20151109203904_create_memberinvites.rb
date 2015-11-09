class CreateMemberinvites < ActiveRecord::Migration
  def change
    create_table :memberinvites do |t|
      t.string :email
      t.integer :receiver_id
      t.integer :sender_id
      t.string :member_token
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :memberinvites, :member_token
  end
end

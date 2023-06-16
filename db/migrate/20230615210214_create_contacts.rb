class CreateContacts < ActiveRecord::Migration[7.0]
  def change

    create_table :contacts do |t|
      t.text :username
      t.text :email
      t.text :text

      t.timestamps
    end 
  end
end

class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :client
      t.string :task
      t.text :objective
      t.string :link

      t.timestamps
    end
  end
end

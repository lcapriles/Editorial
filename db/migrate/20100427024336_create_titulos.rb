class CreateTitulos < ActiveRecord::Migration
  def self.up
    create_table :titulos do |t|
      t.text :nombre
      t.date :fecha
      
      t.column "autor_id", :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :titulos
  end
end

class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.integer :issue_id
      t.integer :project_id
      t.integer :user_id
      t.string :batiment
      t.string :site
      t.string :nom_demandeur
      t.date :date_reclamation
      t.date :date_intevention
      t.string :equipe
      t.integer :travaux_id
      t.integer :nature_intervention_id
      t.text :description_travaux
      t.text :founitures
      t.text :oberservation
      t.boolean :travaux_termines
      t.text :remarque
      t.text :signature
    end
    add_index :interventions, :issue_id
  end
end

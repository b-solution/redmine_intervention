class Intervention < ActiveRecord::Base
  belongs_to :issue
  # belongs_to :user
  belongs_to :project

  def travaux
    {
        "1"=> 'Diagnostic',
        "2"=> 'Entretien',
        "3"=> 'Réparation',
        "4"=> 'Installation',
        "5"=> 'Mise en service',
    }[travaux_id.to_s]
  end


end

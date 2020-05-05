# Redmine - project management software
# Copyright (C) 2006-2017  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class InterventionQuery < Query

  self.queried_class = Intervention

  self.available_columns = [
      QueryColumn.new(:issue, :sortable => "#{Issue.table_name}.subject", :groupable => true),
      QueryColumn.new(:batiment, :sortable => "#{Intervention.table_name}.batiment", :groupable => true),
      QueryColumn.new(:site, :sortable => "#{Intervention.table_name}.site", :groupable => true),
      QueryColumn.new(:nom_demandeur, :sortable => "#{Intervention.table_name}.nom_demandeur", :groupable => true),
      QueryColumn.new(:date_reclamation, :sortable => "#{Intervention.table_name}.date_reclamation", :groupable => true),
      QueryColumn.new(:travaux, :sortable => "#{Intervention.table_name}.travaux", :groupable => true),
      QueryColumn.new(:nature_intervention, :sortable => "#{Intervention.table_name}.nature_intervention", :groupable => true),
  ]

  def initialize(attributes=nil, *args)
    super attributes
    self.filters ||= { 'batiment' => {:operator => "*", :values => []} }
  end

  def initialize_available_filters
    add_available_filter "batiment", :type => :text
    add_available_filter "site", :type => :text
    add_available_filter "date_reclamation", :type => :date
    add_available_filter "date_intevention", :type => :date

    add_available_filter("travaux_id", :type => :list, :values => lambda { travaux_values }  )
    add_available_filter("nature_intervention_id", :type => :list, :values => lambda { nature_intervention_values }  )
    add_available_filter("user_id",  :type => :list_optional, :values => lambda { author_values }
    )

    add_custom_fields_filters(issue_custom_fields, :issue)
    add_associations_custom_fields_filters :user
  end

  def travaux_values
    []
  end

  def nature_intervention_values
    []
  end

  def available_columns
    return @available_columns if @available_columns
    @available_columns = self.class.available_columns.dup
    @available_columns
  end

  def default_columns_names
    @default_columns_names ||= ['batiment', 'site', 'travaux', 'nature_intervention']
  end

  def default_totalable_names
    []
  end

  def default_sort_criteria
    [['id', 'desc']]
  end

  # If a filter against a single issue is set, returns its id, otherwise nil.
  def filtered_issue_id
    if value_for('issue_id').to_s =~ /\A(\d+)\z/
      $1
    end
  end

  def base_scope
    Intervention.visible.
        joins(:issue, :user).
        left_join_issue.
        where(statement)
  end

  def results_scope(options={})
    order_option = [group_by_sort_order, (options[:order] || sort_clause)].flatten.reject(&:blank?)

    base_scope.
        order(order_option).
        joins(joins_for_order_statement(order_option.join(',')))
  end

end

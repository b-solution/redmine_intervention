require_dependency 'issue'

module RedmineIntervention
  module IssuePatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        has_many :interventions
      end
    end

    module InstanceMethods

    end
  end
end

Issue.send(:include, RedmineIntervention::IssuePatch)

# frozen_string_literal: true
module ActiveAdmin
  class Comment < ActiveRecord::Base

    self.table_name = 'fsc_active_admin_comments'

    belongs_to :resource, polymorphic: true, optional: true
    belongs_to :author, polymorphic: true

    validates_presence_of :body, :namespace, :resource

    before_create :set_resource_type

    # @return [String] The name of the record to use for the polymorphic relationship
    def self.resource_type(resource)
      ResourceController::Decorators.undecorate(resource).class.base_class.name.to_s
    end

    def self.find_for_resource_in_namespace(resource, namespace)
      where(
        resource_type: resource_type(resource),
        resource_id: resource.id,
        namespace: namespace.to_s
      ).order(ActiveAdmin.application.namespaces[namespace.to_sym].comments_order)
    end

    def set_resource_type
      self.resource_type = self.class.resource_type(resource)
    end

    def self.ransackable_attributes(auth_object = nil)
      authorizable_ransackable_attributes
    end

    def self.ransackable_associations(auth_object = nil)
      authorizable_ransackable_associations
    end

  end
end

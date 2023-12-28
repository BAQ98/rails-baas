# frozen_string_literal: true

module Components
  module SelectHelper
    def render_select(name:, **options, &block)
      component = Shadcn::SelectComponent.new(name:, view_context: self, **options, &block)
      component.call
    end
  end
end

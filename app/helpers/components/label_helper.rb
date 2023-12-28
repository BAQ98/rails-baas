# frozen_string_literal: true

module Components
  module LabelHelper
    def render_label(name:, label:, **options)
      render 'components/ui/label', name:, label:, options:
    end
  end
end

# frozen_string_literal: true

module Components
  module CheckboxHelper
    def render_checkbox(label:, name:, **options)
      render 'components/ui/checkbox', name:, label:, options:
    end
  end
end

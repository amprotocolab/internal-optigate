class FormField < ApplicationRecord
  enum field_type: { button: 0, checkbox: 1 }
  enum alignment_type: { left: 0, center: 1, right: 2 }

  belongs_to :formable, polymorphic: true
   validates :field_type, :label, :font_type, :font_size, :font_family, :fill_color, :fill_color_percent, :alignment_type, presence: true

end

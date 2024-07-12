  class FormField < ApplicationRecord

  belongs_to :form
  
  enum field_type: { button: 0, checkbox: 1 }
  enum alignment_type: { left: 0, center: 1, right: 2 }
    
  validates :uuid, presence: true, uniqueness: true
  validates :field_type, presence: true
  validates :custom_css, presence: true
  validates :label, presence: true
  validates :font_type, presence: true
  validates :font_size, presence: true   
  validates :font_family, presence: true
  validates :fill_color, presence: true
  validates :fill_color_percent, presence: true
  validates :alignment_type, presence: true


  end

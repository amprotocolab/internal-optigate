class FormTemplate < ApplicationRecord
  enum form_type: { modal: 0, slidein: 1, inline: 2, stickybar: 3 }

  has_many :form_fields, as: :formable

  validates :form_type, :title, presence: true
  validates :custom_css, :html_script, presence: true, if: -> { form_type == 'modal' }
  validates :prebuilt_template, inclusion: { in: [true, false] }

end

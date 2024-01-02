ActiveAdmin.register Price do
  permit_params :name, :value, price_pointers_attributes: [:id, :description, :subtitle, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :value
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :value
    end

    f.inputs 'Price Pointers' do
      f.has_many :price_pointers, heading: 'Price Pointers', allow_destroy: true, new_record: true do |pp|
        pp.input :description
        pp.input :subtitle
      end
    end

    f.actions
  end
end

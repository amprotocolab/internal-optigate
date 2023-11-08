class AddExtensions < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'plpgsql' unless extension_enabled?('plpgsql')
    enable_extension 'unaccent' unless extension_enabled?('unaccent')
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')
  end
end

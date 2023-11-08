module Users
  class RoleSanitizer
    def self.role_ids(current_user, updated_user_id, role_ids = [])
      new(current_user, updated_user_id, role_ids).call
    end

    def initialize(current_user, updated_user_id, role_ids = [])
      @current_user    = current_user
      @updated_user_id = updated_user_id
      @role_ids        = role_ids
    end

    def call
      return {} if role_ids.blank? || !can_edit_roles? || admin_edits_super_admin?

      role_ids.reject! { |role_id| role_id.to_s == Role.super_admin.id.to_s } unless current_user.super_admin?

      { role_ids: role_ids }.reject { |_, v| v.blank? }
    end

    private

    attr_reader :current_user, :role_ids

    def can_edit_roles?
      current_user.administrator?
    end

    def admin_edits_super_admin?
      return false if @updated_user_id.blank?

      updated_user = User.find(@updated_user_id)
      !current_user.super_admin? && updated_user.super_admin?
    end
  end
end

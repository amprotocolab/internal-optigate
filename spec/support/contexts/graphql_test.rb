RSpec.shared_context 'GraphQL test' do
  let(:user) { create(:user, :super_admin) }
  let(:context) { { current_user: user, current_ability: Ability.new(user) } }
  let(:variables) { {} }
  let(:response) do
    AgencyWatcherSchema.execute(query, context: context, variables: variables).deep_symbolize_keys
  end
end

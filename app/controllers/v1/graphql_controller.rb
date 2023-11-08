module API
  module V1
    class GraphqlController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action :authenticate_user!, only: [:execute, :execute_dev]

      def execute
        result = if params[:_json]
          InternalOptigateSchema.multiplex(
            params[:_json].map do |param|
              { query: param[:query] }.merge(**execute_params(param))
            end
          )
        else
          InternalOptigateSchema.execute(params[:query], **execute_params(params))
        end

        render json: result
      end

      def execute_dev
        user = current_user || User.new
        result = InternalOptigateSchema.execute(params[:query], **execute_params(params, user))
        render json: result
      end

      private

      def execute_params(item, user = current_user)
        {
          operation_name: item[:operationName],
          variables:      ensure_hash(item[:variables]),
          context:        {
            current_user:    user,
            current_ability: Ability.new(user)
          }
        }
      end

      def ensure_hash(ambiguous_param)
        case ambiguous_param
        when String
          if ambiguous_param.present?
            ensure_hash(JSON.parse(ambiguous_param))
          else
            {}
          end
        when Hash, ActionController::Parameters
          ambiguous_param
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
        end
      end
    end
  end
end

# frozen_string_literal: true

module OpenFeature
  module SDK
    class EvaluationContext
      TARGETING_KEY = "targeting_key"

      attr_reader :fields

      def initialize(**fields)
        @fields = fields.transform_keys(&:to_s)
      end

      def targeting_key
        fields[TARGETING_KEY]
      end

      def field(key)
        fields[key]
      end

      def merge(overriding_context)
        merged = fields
          .merge(overriding_context.fields)
          .merge(TARGETING_KEY => overriding_context.targeting_key || targeting_key)
        EvaluationContext.new(**merged.transform_keys(&:to_sym))
      end

      def ==(other)
        fields == other.fields
      end
    end
  end
end

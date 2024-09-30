# frozen_string_literal: true

envelope json do
  json.sessions do
    json.array! @sessions do |session|
      json.partial! 'api/v1/public/sessions/index_item', session: session
    end
  end
end

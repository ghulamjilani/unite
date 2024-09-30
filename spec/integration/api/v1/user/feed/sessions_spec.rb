# frozen_string_literal: true

require 'swagger_helper'

describe 'Sessions', swagger_doc: 'api/v1/swagger.json' do
  path '/api/v1/user/feed/sessions' do
    get 'Get all sessions of current_user' do
      tags 'User::Feed::Sessions'
      description 'Get all purchased sessions of current_user'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true
      parameter name: :channel_id, in: :query, type: :integer, description: 'Channel ID'
      parameter name: :organization_id, in: :query, type: :integer, description: 'Org ID'
      parameter name: :presenter_id, in: :query, type: :integer, description: 'Presenter ID'
      parameter name: :booking, in: :query, type: :boolean, description: 'Booked session'
      parameter name: :order_by, in: :query, type: :string, description: "Valid values are: 'start_at', 'end_at'. Default: 'start_at'"
      parameter name: :order, in: :query, type: :string, description: "Valid values are: 'asc', 'desc'. Default: 'asc'"
      parameter name: :offset, in: :query, type: :integer
      parameter name: :limit, in: :query, type: :integer

      response '200', 'Found' do
        run_test!
      end
    end
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe SessionsController, 'POST :create' do
  before { sign_in current_user, scope: :user }

  before do
    create(:ffmpegservice_account)
  end

  let(:channel) { create(:listed_channel) }
  let(:ffmpegservice_account) { create(:ffmpegservice_account, organization_id: channel.organization_id) }
  let(:current_user) { channel.organizer }

  let(:year) { 2014 }
  let(:month) { 1 }
  let(:day) { 16 } # in 10 days from frozen time
  let(:hour) { 18 }
  let(:minute) { 30 }
  let(:current_time) { Chronic.parse('Jan 6th, 2014 at 6:45pm') }

  context 'with free trial for first time participants option' do
    let(:default_session_params) do
      {
        adult: 0,
        age_restrictions: 0,
        duration: 60,
        free_trial_for_first_time_participants: '1',
        # "requested_free_session_reason" => "",
        immersive: '1',
        immersive_access_cost: 12.22,
        immersive_free_slots: 2,
        immersive_type: Session::ImmersiveTypes::GROUP,
        level: 'Advanced',
        max_number_of_immersive_participants: 15,
        min_number_of_immersive_and_livestream_participants: '2',
        pre_time: 0,
        # private: 0, equivalent to unchecked checkbox
        publish_immediately: 1,
        record: '1',
        recorded_access_cost: 13.99,
        'start_at(1i)' => year,
        'start_at(2i)' => month,
        'start_at(3i)' => day,
        'start_at(4i)' => hour,
        'start_at(5i)' => minute,
        title: 'a' * 55,
        livestream: '1',
        livestream_access_cost: 23.22,
        livestream_free_slots: '2',
        ffmpegservice_account_id: ffmpegservice_account.id
      }
    end

    before { Timecop.freeze(current_time) }

    it 'succesfully creates session' do
      post :create,
           params: { channel_id: channel.slug, session: default_session_params,
                     clicked_button_type: SessionFormButtonTypes::SAVE_AS_NON_DRAFT }

      expect(assigns[:session].errors.full_messages.inspect).to be_nil if assigns[:session] && assigns[:session].errors.present?

      expect(Session.count).to eq(1)

      session = Session.last
      expect(session.free_trial_for_first_time_participants).to be true
      expect(session.status).to eq('published')
    end
  end

  context 'with requested completely free session' do
    let(:default_session_params) do
      {
        adult: 0,
        age_restrictions: 0,
        duration: 60,
        # free_trial_for_first_time_participants: "",  equivalent to unchecked checkbox
        immersive_free: 'true',
        livestream_free: 'true',
        # "requested_free_session_reason" => "because I'm providing a great content and that would be great advertisement for Immerss",
        immersive: '1',
        immersive_access_cost: '3.21',
        immersive_free_slots: 2,
        immersive_type: Session::ImmersiveTypes::GROUP,
        level: 'Advanced',
        max_number_of_immersive_participants: 15,
        min_number_of_immersive_and_livestream_participants: '2',
        pre_time: 0,
        # private: 0, equivalent to unchecked checkbox
        publish_immediately: 1,
        record: '1',
        recorded_access_cost: 13.99,
        'start_at(1i)' => year,
        'start_at(2i)' => month,
        'start_at(3i)' => day,
        'start_at(4i)' => hour,
        'start_at(5i)' => minute,
        title: 'a' * 55,
        livestream: '1',
        livestream_access_cost: 23.22,
        livestream_free_slots: '',
        ffmpegservice_account_id: ffmpegservice_account.id
      }
    end

    before { Timecop.freeze(current_time) }

    it 'succesfully creates session' do
      post :create,
           params: { channel_id: channel.slug, session: default_session_params,
                     clicked_button_type: SessionFormButtonTypes::SAVE_AS_NON_DRAFT }

      expect(assigns[:session].errors.full_messages.inspect).to be_nil if assigns[:session] && assigns[:session].errors.present?

      expect(Session.count).to eq(1)

      session = Session.last
      expect(session.status).to eq(Session::Statuses::PUBLISHED)

      expect(session.immersive_access_cost.zero?).to eq(true)
      expect(session.livestream_access_cost.zero?).to eq(true)
    end
  end
end
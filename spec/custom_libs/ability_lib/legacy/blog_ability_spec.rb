# frozen_string_literal: true

require 'spec_helper'
require 'cancan/matchers'

describe AbilityLib::Legacy::BlogAbility do
  let(:subject) { described_class.new(current_user) }
  let(:blog_post) { create(:blog_post) }

  describe '#edit(Blog::Post)' do
    context 'when given organization membership moderator' do
      let(:current_user) do
        create(:organization_membership_blog_moderator, organization_id: blog_post.organization_id).user
      end

      it { is_expected.to be_able_to :edit, blog_post }
    end

    context 'when given organization membership blog owner' do
      let(:current_user) do
        create(:organization_membership_blog_manager, organization_id: blog_post.organization_id).user
      end

      it { is_expected.to be_able_to :edit, blog_post }
    end

    context 'when given random user' do
      let(:current_user) { create(:user) }

      it { is_expected.not_to be_able_to :edit, blog_post }
    end
  end

  describe '#read(Blog::Post)' do
    context 'when given published post' do
      let(:blog_post) { create(:blog_post_published) }

      context 'when given organization membership administrator' do
        let(:current_user) do
          create(:organization_membership_administrator, organization_id: blog_post.organization_id).user
        end

        it { is_expected.to be_able_to :read, blog_post }
      end

      context 'when given random user' do
        let(:current_user) { create(:user) }

        it { is_expected.to be_able_to :read, blog_post }
      end

      context 'when given service_admin user' do
        let(:current_user) { create(:user_service_admin) }

        it { is_expected.to be_able_to :read, blog_post }
      end
    end

    context 'when given hidden post' do
      let(:blog_post) { create(:blog_post_hidden) }

      context 'when given organization membership administrator' do
        let(:member) { create(:organization_membership_administrator, organization_id: blog_post.organization_id) }
        let(:current_user) { member.user }
        let(:role) { create(:access_management_group) }

        before do
          create(:access_management_groups_credential,
                 credential: create(:access_management_credential, code: :manage_blog_post), group: role)
          create(:access_management_groups_member, organization_membership: member, group: role)
        end

        it { is_expected.to be_able_to :read, blog_post }
      end

      context 'when given random user' do
        let(:current_user) { create(:user) }

        it { is_expected.not_to be_able_to :read, blog_post }
      end

      context 'when given service_admin user' do
        let(:current_user) { create(:user_service_admin) }

        it { is_expected.to be_able_to :read, blog_post }
      end
    end
  end
end

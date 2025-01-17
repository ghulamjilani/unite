# frozen_string_literal: true

require 'spec_helper'

describe Spa::Dashboard::Blog::PostsController do
  let(:comment_on_comment) { create(:blog_comment_on_comment) }
  let(:blog_post) { comment_on_comment.post }
  let(:current_user) { blog_post.user }

  render_views

  context 'when user is a guest' do
    it 'redirects to root' do
      get :index, params: {}
      expect(response).to be_redirect
    end
  end

  context 'when user is logged in' do
    before do
      sign_in(current_user)
    end

    describe 'GET index:' do
      it 'shows posts' do
        get :index, params: {}
        expect(response).to be_successful
      end
    end

    describe 'GET new:' do
      it 'shows post' do
        get :new, params: {}
        expect(response).to be_successful
      end
    end

    describe 'GET show:' do
      it 'shows post' do
        get :show, params: { id: blog_post.id }
        expect(response).to be_successful
      end
    end
  end
end

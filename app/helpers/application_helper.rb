# frozen_string_literal: true

module ApplicationHelper
  def sign_in_button
    link_to '/auth/facebook', class: 'btn btn-block btn-social btn-facebook login-button' do
      concat content_tag(:span, '', class: 'fa fa-facebook')
      concat content_tag(:p, 'Sign in with Facebook')
    end
  end
end

class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
  end

  def dashboard
    @cards = [
        {
            label: '.self',
            links: [
                {label: 'shared.personal-bar.profile', href: edit_user_registration_path},
                {label: 'devise.invitations.new.header', href: new_user_invitation_path},
            ]
        },
    ]

    if current_user.is_admin?
      @cards << {
          label: '.site',
          links: [
              {label: 'leave_words.index.title', href: leave_words_path},
          ]
      }
    end

  end

  def search

  end
end
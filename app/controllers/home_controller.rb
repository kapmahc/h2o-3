class HomeController < ApplicationController

  def index
  end

  def dashboard
    authorize :dashboard, :sign_in?
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
              {label: 'admin.site.status.title', href: admin_site_status_path},
              {label: 'admin.site.info.title', href: admin_site_info_path},
              {label: 'leave_words.index.title', href: leave_words_path},
          ]
      }
    end

  end

  def search

  end
end
authorization do
  role :active_bundles do
    has_permission_on :bundles, :to => :read do
      if_attribute :state => is { 'active' }
    end
    has_permission_on :games, :to => :read do
      if_permitted_to :read, :bundle
    end
  end

  role :base_reporter do
    has_permission_on :predefined_tags, :to => :read
    has_permission_on :issues, :to => [:read,:create] do
      if_permitted_to :read, :game
    end
    has_permission_on :issues, :to => :update do
      if_attribute :author => is { user }
    end
    has_permission_on :notes, :to => :create do
      if_permitted_to :read, :noteable
    end
  end

  role :guest do
    includes :active_bundles

    has_permission_on :users, :to => :create
  end

  # new user signups before they verify their email address
  role :unverified do
    includes :active_bundles
    has_permission_on :users, :to => [:read, :update] do
      if_attribute :id => is { user.id }
    end
  end

  # after a new user verifies their email they gain user
  role :user do
    includes :active_bundles
    includes :base_reporter
  end

  role :tester do
    includes :user
    has_permission_on :games, :to => :read do
      if_attribute :state => is_in { [ 'testing', 'completed' ] }
    end
  end

  role :porter do
    includes :user
    has_permission_on :games, :to => :read do
      if_attribute :ports => { :porter => is { user } }
    end
    has_permission_on :releases, :to => :manage do
      if_permitted_to :read, :game
    end
    has_permission_on :issues, :to => :update do
      if_permitted_to :read, :game
    end
  end

  role :bundle_admin do
    has_permission_on :predefined_tags, :to => :manage
    has_permission_on :bundles, :to => :manage
    has_permission_on :games, :to => :manage
    has_permission_on [:ports, :releases, :issues], :to => :manage do
      if_permitted_to :manage, :game
    end
  end

  role :admin do
    has_omnipotence
  end

  if Rails.env.test?
    # this is used by tests which aren't specifically testing authorization
    role :dev do
      has_omnipotence
    end
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
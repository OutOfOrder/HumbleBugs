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
    has_permission_on :issues, :to => [:read, :create] do
      if_permitted_to :read, :game
    end
    has_permission_on :issues, :to => [:read, :update] do
      if_attribute :author => is { user }
    end
    has_permission_on :comments, :to => :read do
      if_permitted_to :read, :commentable
    end
    has_permission_on :comments, :to => [:create,:update, :delete], :join_by => :and do
      if_permitted_to :read, :commentable
      if_attribute :author => is { user }
    end
  end

  role :guest do
    includes :active_bundles

    has_permission_on :users, :to => :create
  end

  # new user signups before they verify their email address
  role :unverified do
    title 'Unverified user'
    includes :active_bundles
    has_permission_on :users, :to => [:read, :update] do
      if_attribute :id => is { user.id }
    end
  end

  # after a new user verifies their email they gain user
  role :user do
    title 'User'
    includes :active_bundles
    includes :base_reporter

    has_permission_on :users, :to => [:read, :update, :nda] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :systems, :to => [:manage] do
      if_attribute :user => is { user }
    end
  end

  role :base_test_results do
    has_permission_on :test_results, :to => [:read, :create] do
      if_permitted_to :read, :release
    end
    has_permission_on :test_results, :to => [:update, :delete], :join_by => :and do
      if_permitted_to :read
      if_attribute :user => is { user }
    end
  end

  role :tester do
    title 'Game tester'
    includes :user
    has_permission_on :games, :to => [:read, :read_testing] do
      if_attribute :state => is_in { [ 'testing', 'completed' ] }
    end
    has_permission_on :ports, :to => :read do
      if_permitted_to :read_testing, :game
    end
    has_permission_on :releases, :to => :read do
      if_permitted_to :read, :game
    end
    includes :base_test_results
  end

  role :porter do
    title 'Game porter'
    includes :user
    has_permission_on :games, :to => [:read, :read_port] do
      if_attribute :ports => { :porter => is { user } }
    end
    has_permission_on :ports, :to => :read do
      if_permitted_to :read_port, :game
    end
    has_permission_on :ports, :to => :update do
      if_attribute :porter => is { user }
    end
    has_permission_on :releases, :to => :manage do
      if_permitted_to :read_port, :game
    end
    has_permission_on :issues, :to => :update do
      if_permitted_to :read_port, :game
    end
    includes :base_test_results
  end

  role :bundle_admin do
    title 'Bundle admin'
    has_permission_on :predefined_tags, :to => :manage
    has_permission_on :bundles, :to => :manage
    has_permission_on :games, :to => :manage
    has_permission_on [:ports, :releases, :issues], :to => :manage do
      if_permitted_to :manage, :game
    end
    includes :base_test_results
    has_permission_on :comments, :to => :manage do
      if_permitted_to :manage, :commentable
    end
    has_permission_on :users, :to => [:manage, :update_roles]
    has_permission_on :users, :to => [:nda] do
      if_attribute :id => is { user.id }
    end
    has_permission_on :systems, :to => :read do
      if_permitted_to :read, :user
    end
    has_permission_on :systems, :to => :manage do
      if_attribute :user => is { user }
    end
  end

  role :admin do
    title 'Administrator'
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
  privilege :read, :releases, :includes => :download
end
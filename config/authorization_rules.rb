authorization do
  role :guest do
    includes :nonvalidated

    has_permission_on :users, :to => :create
  end

  role :nonvalidated do
    has_permission_on :bundles, :to => :read do
      if_attribute :state => is { 'active' }
    end
    has_permission_on :games, :to => :read do
      if_permitted_to :read, :bundle
    end
  end

  role :admin do
    has_omnipotence
  end

  role :dev do
    has_omnipotence
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
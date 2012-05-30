authorization do
  role :guest do
    has_permission_on :bundles, :to => [:read]
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
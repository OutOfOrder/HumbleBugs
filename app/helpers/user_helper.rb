module UserHelper
  def role_titles roles
    roles.map {|r|
      Authorization::Engine.instance.title_for(r) || r.to_s.humanize
    }
  end

  def system_roles
    Authorization::Engine.instance.role_titles.reject { |k,v| k == :unverified }
  end

  def role_description role
    Authorization::Engine.instance.description_for(role)
  end
end

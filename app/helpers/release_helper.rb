module ReleaseHelper
  def available_release_statuses(game)
    if permitted_to? :manage, game.releases
      Types::Release::STATUSES
    else
      Types::Release::STATUSES.collect {|t| Types::Release::TESTER_STATUSES.include?(t.second) }
    end
  end
end
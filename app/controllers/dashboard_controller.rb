class DashboardController < ApplicationController
  def index
    dashboard_columns = current_user ? current_user.dashboard_columns : [[:news]]
    dashboard_columns << [] << [] << [] # ensure 3 columns

    @column1 = dashboard_columns.first.map {|w| widget_for w } .compact
    @column2 = dashboard_columns.second.map {|w| widget_for w } .compact
    @column3 = dashboard_columns.third.map {|w| widget_for w} .compact
  end

private
  def widget_for name
    m = "widget_#{name}".to_sym
    o = Hash.new
    o[:name] = name.to_s
    if respond_to?(m, true)
      send(m, o)
    else
      nil
    end
  end

  def widget_news data
    data
  end

  def widget_testing_games data
    data[:games] = Game.testing.with_permissions_to
    data
  end

  def widget_new_issues data
    data[:issues] = Issue.with_permissions_to.where(:game_id => Game.testing.with_permissions_to).order('issues.created_at DESC').includes(:game).limit(5)
    data
  end

  def widget_recently_commented_on data
    data[:issues] = Issue.with_permissions_to.joins(:comments).order("comments.updated_at DESC").includes(:game).limit(10)
    data
  end

  def widget_game_ports data
    data[:games] = Game.joins(:ports).merge( Port.where(:porter_id => current_user))
    data
  end
end

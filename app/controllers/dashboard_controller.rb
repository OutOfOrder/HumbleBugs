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
end

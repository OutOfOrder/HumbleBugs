class DashboardController < ApplicationController
  def show
    columns = dashboard_columns
    columns << [] << [] << [] # ensure 3 columns

    @column1 = columns.first.map {|w| widget_for w } .compact
    @column2 = columns.second.map {|w| widget_for w } .compact
    @column3 = columns.third.map {|w| widget_for w} .compact
  end

private
  def dashboard_columns
    if current_user.nil?
      [[:news]]
    elsif current_user.dashboard.present?
      logger.info "Using Custom Dashboard"
      current_user.dashboard
    else
      is_developer = current_user.developer.present?
      is_tester    = current_user.role_symbols.include?(:tester)
      is_admin     = current_user.role_symbols.include?(:bundle_admin)
      if is_admin
        [[:news], [:testing_games, :recently_commented_on, :new_issues], [:game_ports]]
      elsif is_tester && !is_developer
        [[:news, :my_issues], [:testing_games, :recently_commented_on, :new_issues]]
      elsif is_developer
        [[:news, :my_issues], [:testing_games, :recently_commented_on, :new_issues], [:my_game_ports, :my_games]]
      else
        [[:news]]
      end
    end
  end

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
    data[:games] = Game.testing.with_permissions_to.order('games.name ASC')
    data[:view] = 'game_list'
    data
  end

  def widget_new_issues data
    data[:issues] = Issue.with_permissions_to.where(:game_id => Game.with_permissions_to).order('issues.created_at DESC').includes(:game).limit(5)
    data
  end

  def widget_recently_commented_on data
    data[:issues] = Issue.with_permissions_to.joins(:comments).order("comments.updated_at DESC").includes(:game).limit(10)
    data
  end

  def widget_game_ports data
    data[:games] = Game.joins(:ports).uniq.order('games.name ASC')
    data[:view] = 'game_list'
    data
  end

  def widget_my_games data
    if current_user.developer.present?
      data[:games] = current_user.developer.games.order('games.name ASC')
    else
      data[:games] = []
    end
    data[:view] = 'game_list'
    data
  end

  def widget_my_game_ports data
    data[:games] = Game.joins(:ports).merge( Port.where(:developer_id => current_user.developer_id)).uniq.order('games.name ASC')
    data[:view] = 'game_list'
    data
  end

  def widget_my_issues data
    i = Issue.arel_table
    sub = Comment.select('commentable_id').scoped_by_commentable_type_and_author_id('Issue',current_user.id)
    data[:issues] = Issue.where(i[:author_id].eq(current_user.id).
                                    or(i[:id].in(sub.arel))).order('issues.updated_at DESC')
    data[:view] = 'issue_list'
    data
  end
end

module ExtraURLHelpers
  ['path', 'url'].each do |method|
    self.module_eval <<-EOV, __FILE__, __LINE__
      def issue_#{method} issue, options = {}
        game_issue_#{method} issue.game, issue, options
      end

      def comment_#{method} comment, options = {}
        polymorphic_#{method} [comment.commentable, comment], options
      end

      def edit_comment_#{method} comment, options = {}
        edit_polymorphic_#{method} [comment.commentable, comment], options
      end
    EOV
  end
end
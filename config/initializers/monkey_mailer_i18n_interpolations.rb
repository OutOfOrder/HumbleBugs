raise 'Monkey Patch no longer needed!' if Rails::VERSION::MAJOR >= 4

module ActionMailer
  class Base
    # If the subject has interpolations, you can pass them through the +interpolations+ parameter.
    def default_i18n_subject(interpolations = {})
      mailer_scope = self.class.mailer_name.tr('/', '.')
      I18n.t(:subject, interpolations.merge(scope: [mailer_scope, action_name], default: action_name.humanize))
    end
  end
end

unless Rails.env.production?
  require 'ci/reporter/rake/cucumber'
  namespace :ci do
    desc 'Run all features and generate Jenkins output'
    task :cucumber do
      Rake::Task['ci:setup:cucumber_report_cleanup'].invoke
      ENV['CUCUMBER_OPTS'] = "#{ENV['CUCUMBER_OPTS']} -f CI::Reporter::Cucumber"
      Rake::Task['cucumber'].invoke
    end
  end
end

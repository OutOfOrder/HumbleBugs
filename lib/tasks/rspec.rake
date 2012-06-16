begin
  task :stats => "spec:role_statsetup"

  namespace :spec do
    desc "Run the code examples in spec/roles"
    RSpec::Core::RakeTask.new(:roles => "db:test:prepare") do |t|
      t.pattern = "./spec/roles/**/*_spec.rb"
    end

    task :role_statsetup do
      require 'rails/code_statistics'
      ::STATS_DIRECTORIES << %w(Role\ specs spec/roles) if File.exist?('spec/roles')
      ::CodeStatistics::TEST_TYPES << "Role specs" if File.exist?('spec/roles')
    end
  end
rescue
  # We are in prod mode so no rspec
end
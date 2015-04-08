# A sample Guardfile
# More info at https://github.com/guard/guard#readme

clearing :on
#interactor :off

guard :bundler do
  watch('Gemfile')
  # watch(/^.+\.gemspec/)
end

group 'interactive' do
  guard 'pow', notification: false do
    watch(%r{^lib})
    watch(%r{^app/(.+)\.rb})
    watch(%r{^config})
  end
end

group 'rspec' do
  guard :rspec, cmd: 'spring rspec -fd' do
    watch(%r{^spec/.+_spec\.rb$})
    watch('spec/spec_helper.rb')  { 'spec' }
    watch('spec/rails_helper.rb') { 'spec' }

    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }

    # Rails example
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }

    watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
    watch('app/controllers/application_controller.rb')    { 'spec/controllers' }
    watch('app/controllers/authenticated_controller.rb')  { 'spec/controllers' }

    # Capybara features specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }

    watch(%r{^spec/factories/(.+)\.rb$})                { 'spec' }
  end
end


# Adapted from Github's API documentation Deployment Rakefile
# https://github.com/github/developer.github.com/blob/master/Rakefile
require 'nanoc3/tasks'
require 'tmpdir'
require 'rake'

task :default => [:compile]

desc "Compile the site"
task :compile do
  `nanoc compile`
end

desc "Test the output"
task :test => [:clean, :remove_output_dir, :compile] do
  require 'html/proofer'
  HTML::Proofer.new("./public").run
end

desc "Remove the output dir"
task :remove_output_dir do
  FileUtils.rm_r('public') if File.exist?('public')
end

# Prompt user for a commit message; default: P U B L I S H :emoji:
def commit_message(no_commit_msg = false)
  publish_emojis = [':boom:', ':rocket:', ':metal:', ':bulb:', ':zap:',
    ':sailboat:', ':gift:', ':ship:', ':shipit:', ':sparkles:', ':rainbow:']
  default_message = "P U B L I S H #{publish_emojis.sample}"

  unless no_commit_msg
    print "Enter a commit message (default: '#{default_message}'): "
    STDOUT.flush
    mesg = STDIN.gets.chomp.strip
  end

  mesg = default_message if mesg.nil? || mesg == ''
  mesg.gsub(/'/, '') # Allow this to be handed off via -m '#{message}'
end

desc "Publish to http://developer.letsfreckle.com"
task :publish, [:branch, :no_commit_msg] => [:clean, :remove_output_dir] do |t, args|
  args.with_defaults(:branch => 'alpha', :no_commit_msg => nil)

  puts "publishing `#{args[:branch]}` to github pages"
  mesg = commit_message(args[:no_commit_msg])

  puts "compiling site"
  sh "nanoc compile"


  puts "getting the location of git's hidden directory"
  ENV['GIT_DIR'] = File.expand_path(`git rev-parse --git-dir`.chomp)
  ENV['RUBYOPT'] = nil

  puts "getting the sha of the latest commit in `gh-pages` branch"
  old_sha = `git rev-parse refs/remotes/origin/gh-pages`.chomp

  puts "navigating to `public`, the location of the compiled site"
  Dir.chdir('public') do

    puts "unlink temporary files used by Github (maybe client app?) if they exist"

    ENV['GIT_INDEX_FILE'] = gif = '/tmp/dev.gh.i'
    ENV['GIT_WORK_TREE'] = Dir.pwd
    File.unlink(gif) if File.file?(gif)

    puts "add *all* changes in `public`"
    `git add -A`


    tsha = `git write-tree`.strip
    puts "Created tree   #{tsha}"
    if old_sha.size == 40
      csha = `git commit-tree #{tsha} -p #{old_sha} -m '#{mesg}'`.strip
    else
      csha = `git commit-tree #{tsha} -m '#{mesg}'`.strip
    end

    puts "Created commit #{csha}"
    puts `git show #{csha} --stat`
    puts "Updating gh-pages from #{old_sha}"
    `git update-ref refs/heads/gh-pages #{csha}`
    `git push origin gh-pages`
  end
end
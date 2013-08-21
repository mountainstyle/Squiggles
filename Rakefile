desc "Clean build directory"
task :clean do
  system_or_exit "rm -rf #{build_root}/*"
end

desc "Trim whitespace"
task :trim_whitespace do
  system_or_exit %Q[git status --short | awk '{if ($1 != "D" && $1 != "R") print $2}' | grep -e '.*\.[cmh]$' | xargs sed -i '' -e 's/	/    /g;s/ *$//g;']
end

desc "Integrate changes with master"
task :integrate => [:clean, :pull, :specs, :push]

desc "Pull changes from master"
task :pull do
  system_or_exit "git pull --rebase"
end

desc "Run specs"
task :specs do
  output = system_or_exit "xcodebuild -scheme Squiggles test SYMROOT='#{build_root}'"
  raise "******** Task failed ********" if output =~ /^FAILURE/
end

desc "Push changes to master"
task :push do
 system_or_exit "git push origin master"
end

#
#  Helper functions
#

def project_root
  File.dirname(__FILE__)
end

def build_root
  build_root = File.join(project_root, "build")
  Dir.mkdir(build_root) unless File.exists?(build_root)
  build_root
end

def system_or_exit(command)
  puts "Executing #{command}"
  output = pty_open(command) do |io|
    io.collect { |line| print line; line }
  end
  raise "******** Task failed ********" if $?.to_i != 0

  output.join
end

require 'pty'

def pty_open(command)
   PTY.spawn(command) do |stdin, stdout, pid|
      begin
        return yield stdin
      rescue Errno::EIO
      ensure
        Process.wait(pid)
      end
    end
  rescue PTY::ChildExited
    puts "******* WARNING! Child exited"
end

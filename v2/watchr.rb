def compile_less
    %x[lessc css/less/screen.less /css/screen.css --yui-compress]
end

def do_growl(message)
    growlnotify = `which growlnotify`.chomp
  title = "Watchr Message"
  passed = message.include?('0 failures, 0 errors')
  image = passed ? "~/.watchr_images/passed.png" : "~/.watchr_images/failed.png"
  severity = passed ? "-1" : "1"
  options = "-w -n Watchr --image '#{File.expand_path(image)}'"
  options << " -m '#{message}' '#{title}' -p #{severity}"
  system %(#{growlnotify} #{options} &)
end

do_growl "Watching folders and waiting for changes .."

watch('css/less/*') { |m|
    # Recompile LESS files
    compile_less
    do_growl "LESS Compiled and Compressed!"
}

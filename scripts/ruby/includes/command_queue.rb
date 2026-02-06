# frozen_string_literal: true

class CommandQueue
  attr_accessor :commands, :session_name

  def initialize(session_name)
    @commands = []
    @session_name = session_name
  end

  def create_session(screen_name, path)
    _add "new-session -c '#{path}' -n \"#{screen_name}\" -s '#{session_name}'"
  end

  def attach_session
    _add "attach-session -t #{session_name}"
  end

  def new_window(name, path)
    _add "new-window -c #{path} -n \"#{name}\" /bin/bash -i"
    _add "split-window -v -c #{path} /bin/bash -i"
  end

  def exec_command_inside_screen(screen, pane, command)
    _add "select-window -t #{screen}"
    _add "send-keys -t #{pane} C-z '#{command.gsub("'", "\\\\'")}' Enter"
  end

  def swap_panes(src, dst)
    _add "swap-pane -s #{src} -t #{dst}"
  end

  def exit_session
    _add "detach-client -s #{session_name}"
    # _add "select-window -t 'info'"
    # _add "send-keys -t \"0\" C-z 'tmux detach-client -s #{session_name}' Enter"
  end

  def run
    exit_session
    exec_command("tmux #{commands.join(" ';' \\\n    ")}")
  end

  def exec_command(cmd)
    puts 'Running Command:'
    puts cmd.blue
    cmd.gsub("'", "\\\\'")
    sleep 0.3
    `#{cmd}`
  end

  private

  def _add(cmd)
    commands.push(cmd)
  end

  # Time.now.strftime('%Y-%m-%d %H:%M:%S')
end

require 'cinch'

module Plugins
  class YouveGotMail
    include Cinch::Plugin

    listen_to(:join, method: :execute)

    # @param msg [Cinch::Message]
    def execute(msg)
      table = LittleHelper.message_table
      to_column = table.map(:to)
      if to_column.include?(msg.user.nick) || to_column.include?(msg.user.authname)
        msg.channel.send("#{msg.user.nick}: You've got mail! Use the checkmail command to check your mail!")
      end
    end
  end
end
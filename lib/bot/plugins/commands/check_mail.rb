require 'cinch'

module Plugins
  module Commands
    class CheckMail
      include Cinch::Plugin

      match(/checkmail/)

      DOC = 'Checks the user mail and sends it to them *publicly*. No arguments.'.freeze
      Variables::NonConstants.add_command('checkmail', DOC)

      # @param msg [Cinch::Message]
      def execute(msg)
        table = LittleHelper.message_table
        user = msg.user
        their_messages = table.where(to: [user.nick.downcase, user.authname&.downcase])
        count = their_messages.count

        if count < 1
          msg.reply('You have no unread messages.')
          return
        end

        msg.reply("You have #{count} unread messages. Reading...")
        deleted = 0
        their_messages.each do |hash|
          # Use msg.user.nick instead of hash[:to] because it is lowercase, but nick has proper formatting/casing.
          msg.reply("#{user.nick}: #{hash[:from]} says \"#{hash[:msg]}\"")
          deleted += table.where(id: hash[:id]).delete
        end
        msg.reply("Finished reading unread messages. Deleted #{deleted} message#{deleted == 1 ? '' : 's'}.")
      end
    end
  end
end

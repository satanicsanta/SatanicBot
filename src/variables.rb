require 'dotenv'

module Variables
  module Constants
    PWD = Dir.pwd

    Dotenv.load

    IRC_USERNAME = ENV['IRC_USERNAME'].freeze
    IRC_PASSWORD = ENV['IRC_PASSWORD'].freeze
    IRC_REALNAME = ENV['IRC_REALNAME'].freeze
    IRC_NICKNAMES = ENV['IRC_NICKNAMES'].split(',').freeze
    IRC_SERVER = ENV['IRC_SERVER'].freeze
    IRC_PORT = ENV['IRC_PORT'].to_i.freeze
    IRC_CHANNELS = ENV['IRC_CHANNELS'].split(',').freeze
    IRC_DEV_CHANNELS = ENV['IRC_DEV_CHANNELS'].split(',').freeze
    WIKI_URL = ENV['WIKI_URL'].freeze
    WIKI_USERNAME = ENV['WIKI_USERNAME'].freeze
    WIKI_PASSWORD = ENV['WIKI_PASSWORD'].freeze
    TWITTER_CONSUMER_KEY = ENV['TWITTER_CONSUMER_KEY'].freeze
    TWITTER_CONSUMER_SECRET = ENV['TWITTER_CONSUMER_SECRET'].freeze
    TWITTER_ACCESS_TOKEN = ENV['TWITTER_ACCESS_TOKEN'].freeze
    TWITTER_ACCESS_SECRET = ENV['TWITTER_ACCESS_SECRET'].freeze
    WUNDERGROUND_KEY = ENV['WUNDERGROUND_API_KEY'].freeze
    PASTEE_KEY = ENV['PASTEE_API_KEY'].freeze
    CLEVER_USER = ENV['CLEVERBOT_API_USER'].freeze
    CLEVER_KEY = ENV['CLEVERBOT_API_KEY'].freeze
    ISSUE_TRACKING = {}
    DISABLED_PLUGINS = ENV['DISABLED_PLUGINS'].split(',')
    IGNORED_USERS = ENV['IGNORED_USERS']
    OWNER = ENV['OWNER']

    githubs = ENV['GITHUB'].split('|')
    githubs.each do |i|
      ary = i.split(',')
      ISSUE_TRACKING[ary[0]] = ary[1]
    end

    ISSUE_TRACKING.freeze

    VALID_PEOPLE = ENV['VALID_AUTHNAMES'].split(',').freeze

    QUOTE_PATH = "#{PWD}/src/info/ircquotes.txt".freeze
    MOTIVATE_PATH = "#{PWD}/src/info/motivate.txt".freeze
    FORTUNE_PATH = "#{PWD}/src/info/8ball.txt".freeze

    LOGGED_IN = 'You must be authenticated for this command. See $help login.'.freeze
    OWNER_ONLY = 'This command is for the owner only.'.freeze
  end

  module NonConstants
    extend self
    @authpass = ENV['DEFAULT_AUTH_PASS']
    @authedusers = []
    @commands = {}

    # Gets the command names and their docs.
    # @return [Hash] The commands.
    def get_commands
      @commands
    end

    # Adds a command to the hash.
    # @param name [String] The command name, basically whatever comes after $.
    # @param doc [String] The documentation of the command for $help.
    def add_command(name, doc)
      @commands[name] = doc
    end

    # Gets the authentication password set in the config or by $setpass..
    # @return [String] The password.
    def get_authentication_password
      @authpass
    end

    # Sets the authentication password to a new value. This does not update the
    #   actual config file.
    # @todo Actually update the config file for a permanent change.
    # @param new_password [String] The new password.
    def set_authentication_password(new_password)
      @authpass = new_password
    end

    # Gets all of the authenticated user's authnames.
    # @return [Array<String>] All of the authenticated user's NickServ usernames
    def get_authenticated_users
      @authedusers
    end

    # Authenticates the given user.
    # @param username [String] The user to authenticate.
    def authenticate_user(authname)
      @authedusers << authname
    end

    # De-authenticates a user.
    # @param username [String] The user to deauthenticate.
    def deauthenticate_user(authname)
      @authedusers.delete(authname)
    end
  end
end

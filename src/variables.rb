require 'yaml'

module Variables
  module Constants
    PWD = Dir.pwd
    CONFIG = YAML.load_file("#{PWD}/config.yml")

    IRC_USERNAME = CONFIG['irc']['username'].freeze
    IRC_PASSWORD = CONFIG['irc']['password'].freeze
    IRC_REALNAME = CONFIG['irc']['realname'].freeze
    IRC_NICKNAMES = CONFIG['irc']['nicknames'].freeze
    IRC_SERVER = CONFIG['irc']['server'].freeze
    IRC_PORT = CONFIG['irc']['port'].freeze
    IRC_CHANNELS = CONFIG['irc']['channels'].freeze
    IRC_DEV_CHANNELS = CONFIG['irc']['dev_channels'].freeze
    WIKI_URL = CONFIG['wiki']['url'].freeze
    WIKI_USERNAME = CONFIG['wiki']['username'].freeze
    WIKI_PASSWORD = CONFIG['wiki']['password'].freeze
    TWITTER_CONSUMER_KEY = CONFIG['twitter']['consumer_key'].freeze
    TWITTER_CONSUMER_SECRET = CONFIG['twitter']['consumer_secret'].freeze
    TWITTER_ACCESS_TOKEN = CONFIG['twitter']['access_token'].freeze
    TWITTER_ACCESS_SECRET = CONFIG['twitter']['access_secret'].freeze
    WUNDERGROUND_KEY = CONFIG['wunderground']['api_key'].freeze
    PASTEE_KEY = CONFIG['pastee']['api_key'].freeze
    ISSUE_TRACKING = {}
    DISABLED_PLUGINS = CONFIG.key?('disabled') ? CONFIG['disabled'] : nil

    CONFIG['github'].each do |i|
      ISSUE_TRACKING[i['channel']] = i['repo']
    end

    ISSUE_TRACKING.freeze

    people_path = "#{PWD}/src/info/valid_authnames.txt"
    VALID_PEOPLE = IO.read(people_path).split("\n").freeze

    QUOTE_PATH = "#{PWD}/src/info/ircquotes.txt".freeze
    MOTIVATE_PATH = "#{PWD}/src/info/motivate.txt".freeze
    FORTUNE_PATH = "#{PWD}/src/info/8ball.txt".freeze

    LOGGED_IN = 'You must be authenticated for this command. See $help login.'.freeze
  end

  module NonConstants
    extend self
    @authpass = Variables::Constants::CONFIG['irc']['default_auth_pass']
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

#we establish in init.rb file the path where the first place for searching any require file 

require 'restaurant'

class Guide
    
    class Config
        @@actions = ['list', 'find', 'add', 'quit']
        def self.actions
            @@actions
        end
    end
    
    def initialize(path=nil)
        #locate the restarant text file at path
        Restaurant.filepath=path
        if Restaurant.file_usable? 
            puts "Found restaurant file"
        #or create a new file
        elsif Restaurant.create_file
            puts "Created restaurant file"
        #exit if create fails
        else 
            puts "Exiting. \n\n"
            exit!
        end
    end
    
    def launch!
        introduction
        #action loop
        # what do you want to do? (list, find, add, quit)
        result=nil
        until result == :quit do
            action = get_action
            result = do_action(action) 
        end
        conclusion
    end

    def get_action
        action = nil
#keep asking for user input until we get a valid action
        until Guide::Config.actions.include?(action)
            puts "Actions:" + Guide::Config.actions.join(",")
            print ">"
            user_response = gets.chomp
            action = user_response.downcase.strip
            return action
        end
    end
    
    def do_action(action)
        case action
            when 'list'
              puts 'Listing...'
            when 'find'
              puts 'Finding...'
            when 'add'
              puts 'Adding...'
            when 'quit'
              return :quit
            else
              puts "\n I don't know this command. \n"
        end
    end
    
    def introduction
        puts "\n\n<<< Welcome to the Food Finder >>>\n\n"
        puts "This is an interactive guide to help you find the food you crave.\n\n"
    end
    
    def conclusion
        puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
    end
    
end

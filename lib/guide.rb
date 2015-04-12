#we establish in init.rb file the path where the first place for searching any require file 

require 'restaurant'
require 'support/string_extend'

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
            action, args = get_action
            result = do_action(action, args) 
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
            args = user_response.downcase.strip.split(' ')
            action = args.shift
            return action, args
        end
    end
    
    def do_action(action, args=[])
        case action
            when 'list'
              list
            when 'find'
            keyword = args.shift  
            find(keyword)
            when 'add'
              add
            when 'quit'
              return :quit
            else
              puts "\n I don't know this command. \n"
        end
    end

    def list
        output_action_header("Listing restaurants")
        restaurants = Restaurant.saved_restaurants
        output_restaurant_table(restaurants)
    end

    def add
        output_action_header("Add a restaurant")
        
        restaurant = Restaurant.build_from_questions
        
        if restaurant.save
            puts "Restaurant added\n\n"
        else 
            puts "\nSave Error: Restaurant not added"
        end
    end

    def find(keyword="")
        output_action_header("Find a restaurant")
        if keyword
            restaurants = Restaurant.saved_restaurants
            found = restaurants.select do |rest|
                rest.name.downcase.include?(keyword.downcase) ||
                rest.cuisine.downcase.include?(keyword.downcase) ||
                rest.price.to_i <= keyword.to_i
                end
            output_restaurant_table(found)
        else 
            puts "Find using a key phrase to search the restaurant list."
            puts "Examples: 'find macdac', 'find CHIpotle', find 'chi'\n\n"
        end

    end
    
    def introduction
        puts "\n\n<<< Welcome to the Food Finder >>>\n\n"
        puts "This is an interactive guide to help you find the food you crave.\n\n"
    end
    
    def conclusion
        puts "\n<<< Goodbye and Bon Appetit! >>>\n\n\n"
    end


    private
    def output_action_header(text)
        puts  "\n#{text.upcase.center(60)}\n\n".upcase
        
    end

    def output_restaurant_table(restaurants=[])
        print " " + "Name".ljust(30)
        print " " + "Cuisine".ljust(20)
        print " " + "Price".rjust(6) + "\n"
        puts "_" * 60
        restaurants.each do |rest|
            line = " " << rest.name.titleize.ljust(30)
            line << " " + rest.cuisine.titleize.ljust(20)
            line << " " + rest.formatted_price.titleize.rjust(6)
            puts line
            end
        puts "No listings found" if restaurants.empty?
        puts "_"*60
    end
    
end

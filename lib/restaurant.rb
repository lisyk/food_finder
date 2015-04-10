class Restaurant

@@filepath=nil
def self.filepath=(path=nil)
   @@filepath=File.join(APP_ROOT, path) 
end

attr_accessor :name, :cuisine, :price

def self.file_exists?
  #class should know if the restaurant file exist
    if @@filepath && File.exists?(@@filepath)
        return true
    else
        return false
    end
end

def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
end

def self.create_file
  #create the restaurtant file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
end

def self.saved_restaurant
  #read the restaurant file
  #return instance of restaurant
end
    
def self.build_from_questions
    args = {}
    print "Restaurant name: "
    args[:name] = gets.chomp.strip
    print "Cuisine Type: " 
    args[:cuisine] = gets.chomp.strip
    print "Average price: "
    args[:price] = gets.chomp.strip

    return self.new(args)
    
end
    
def initialize(args={})
   @name    = args[:name]    || ""
   @cuisine = args[:cuisine] || ""
   @price   = args[:price]   || ""
end

def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|
        file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
end

end

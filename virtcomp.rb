class Computer
    @@users = {}
    def initialize(username, password)
      @username = username
      @password = password
      @files = {}
      @@users[username] = password
    end
  
    def Computer.get_users
      @@users
    end
  
    def create(filename)
      @time = Time.now
      @files[filename] = @time
      puts "#{@username}, #{filename}, #{@time}"
    end
  
    def deleted(filename)
      @files.delete(filename)
      puts "#{@username}, #{filename}, #{@time}"
      end
  end
  
  my_computer = Computer.new("ray", "12345")
  rand = Computer.new("rox", "54321")
  my_computer.create("file.txt")
  my_computer.create("file2.txt")
  
  p Computer.get_users
  my_computer.deleted("file2.txt")
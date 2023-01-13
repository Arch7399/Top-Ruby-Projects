class Player
    @@VSETS = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    def initialize(name)
      @name = name
      @choice = []
    end
    def pick(num)
      "#{@name} picks #{num}"
      @choice << num
      victory
    end
    def victory
      p "#{@name} won the game" if @@VSETS.any? {|element_set| (element_set - @choice).empty?}
    end
  end
  
  ray = Player.new("Arch")
  rex = Player.new("val")
  ray.pick(5)
  rex.pick(1)
  ray.pick(6)
  rex.pick(4)
  ray.pick(7)
  rex.pick(8)
  ray.pick(3)
  
  
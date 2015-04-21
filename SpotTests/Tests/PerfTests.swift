import XCTest
import Spot

class PerfTests: Test {
    
    override func setUp() {
        super.setUp()
    }
    
    func generateModelOfSize(x: Int, y: Int) -> Player {
        var player = Player(id: 100, name: "player", age: 23)
        var players = [Player]()
        var innerPlayers = [Player]()
        for index in 1...y {
            innerPlayers.append(Player(id:index, name: "player\(index)", age:23 ))
        }
        for index in 1...x {
            var newPlayer = Player(id:index, name: "player\(index)", age:23 )
            newPlayer.teamates = innerPlayers
            players.append(newPlayer)
        }
        
        player.teamates = players
        return player
    }
    
    func testTimeEncodingLargeDataSet() {
        var player = self.generateModelOfSize(500, y:10 )
        var data = [String : AnyObject]()
        
        measureBlock() {
            data = Encoder.encodeModel(player)
        }
    }
    
    func testTimeDecodingLargeDataSet() {
        var player = self.generateModelOfSize(500, y:10 )
        var data = [String : AnyObject]()
        
        measureBlock {
            var newPlayer: Player?  = Decoder.decodeModel(data)
        }
    }
    
    func testTimeParsingJSON() {
        measureBlock {
             var data = JSON.read(self.bundlePathFor("Big_data", ofType: "json")!)
        }
    }
    
    func testTimeParsingPlist() {
        measureBlock {
            var data = Plist.read(self.bundlePathFor("Big_data", ofType: "plist")!)
        }
    }
    
    func testTimeParsingBinaryPlist() {
        measureBlock {
            var data = Data.read(self.bundlePathFor("Big_data-bin", ofType: "plist")!)
        }
    }
    
    func testTimeWritingJSON() {
        var data = JSON.read(self.bundlePathFor("Big_data", ofType: "json")!)
        measureBlock {
            JSON.write(data, path: tempPathFor("Big_data.json"))
        }
    }
    
    func testTimeWritingPlist() {
         var data = Plist.read(self.bundlePathFor("Big_data", ofType: "plist")!)
        measureBlock {
            Plist.write(data, path: tempPathFor("Big_data.plist"))
        }
    }
    
    func testTimeWritingBinaryPlist() {
        var data = Data.read(self.bundlePathFor("Big_data-bin", ofType: "plist")!)
        measureBlock {
            Data.write(data, path: tempPathFor("Big_data-bin.plist"))
        }
    }
}
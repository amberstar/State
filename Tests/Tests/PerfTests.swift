import XCTest
import STState

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
        let player = self.generateModelOfSize(500, y:10 )
        
        measureBlock() {
           player.encode()
        }
    }
    
    func testTimeDecodingLargeDataSet() {
        _ = self.generateModelOfSize(500, y:10 )
        let data = [String : AnyObject]()
        
        measureBlock {
            var _ =  Player.decode(data)
        }
    }
    
    func testTimeParsingJSON() {
        measureBlock {
             var _ = JSON.read(self.bundlePathFor("Big_data", ofType: "json")!)
        }
    }
    
    func testTimeParsingPlist() {
        measureBlock {
            var _ = Plist.read(self.bundlePathFor("Big_data", ofType: "plist")!)
        }
    }
    
    func testTimeParsingBinaryPlist() {
        measureBlock {
            var _ = Binary.read(self.bundlePathFor("Big_data-bin", ofType: "plist")!)
        }
    }
    
    func testTimeWritingJSON() {
        let data = JSON.read(self.bundlePathFor("Big_data", ofType: "json")!)
        measureBlock {
            JSON.write(data, path: tempPathFor("Big_data.json"))
        }
    }
    
    func testTimeWritingPlist() {
         let data = Plist.read(self.bundlePathFor("Big_data", ofType: "plist")!)
        measureBlock {
            Plist.write(data, path: tempPathFor("Big_data.plist"))
        }
    }
    
    func testTimeWritingBinaryPlist() {
        let data = Binary.read(self.bundlePathFor("Big_data-bin", ofType: "plist")!)
        measureBlock {
            Binary.write(data, path: tempPathFor("Big_data-bin.plist"))
        }
    }
}

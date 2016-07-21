import XCTest
@testable import State

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
        let player = self.generateModelOfSize(x: 500, y:10 )
        var store = Store()
        
        measure() {
            player.write(to: &store)
        }
    }
    
    func testTimeDecodingLargeDataSet() {
        let p = self.generateModelOfSize(x: 500, y:10 )
        var store = Store()
        p.write(to: &store)
        
        measure {
            var _ =  Player.read(from: store)
        }
    }
    
    func testTimeParsingJSON() {
    
        measure {
            var _ : AnyObject? = Format.json.formatter.read(self.bundleURLFor("Big_data", ofType: "json")!)
        }
    }
    
    func testTimeParsingPlist() {
        measure {
            var _ = Format.plist.formatter.read(self.bundlePathFor("Big_data", ofType: "plist")!)
        }
    }
    
    func testTimeParsingBinaryPlist() {
        measure {
            var _ = Format.binary.formatter.read(self.bundlePathFor("Big_data-bin", ofType: "plist")!)
        }
    }
    
    func testTimeWritingJSON() {
        let data = Format.json.formatter.read(self.bundleURLFor("Big_data", ofType: "json")!)
        measure {
           _ = Format.json.formatter.write(data!, to: self.tempURLFor("Big_data.json"))
        }
    }
    
    func testTimeWritingPlist() {
        let data = Format.plist.formatter.read(self.bundleURLFor("Big_data", ofType: "plist")!)
        measure {
            _ = Format.plist.formatter.write(data!, to: self.tempURLFor("Big_data.plist"))
        }
    }
    
    func testTimeWritingBinaryPlist() {
        let data = Format.binary.formatter.read(self.bundleURLFor("Big_data-bin", ofType: "plist")!)
        measure {
            _ = Format.binary.formatter.write(data!, to: self.tempURLFor("Big_data-bin.plist"))
        }
    }
}

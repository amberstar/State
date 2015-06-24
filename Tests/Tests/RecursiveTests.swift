import XCTest
import State

class RecursiveTests: Test {
    
    func testEncodingAndDecodingRecursiveModel() {
        var player = Player(id: 100, name: "player", age: 23)
        var players = [Player]()
        var innerPlayers = [Player]()
        for index in 1...10 {
            players.append(Player(id:index, name: "player\(index)", age:23 ))
        }
        for index in 1...5 {
            innerPlayers.append(Player(id:index, name: "player\(index)", age:23 ))
        }
        
        player.teamates = players
        player.teamates[3].fillins = innerPlayers
        
        Plist.write(Encoder.encodeModel(player), path: tempPathFor("player.plist"))
        let resultPlayer = Player.decode(Plist.read(tempPathFor("player.plist")))
        
        XCTAssert(resultPlayer != nil)
        XCTAssert(resultPlayer?.teamates.count == 10)
        XCTAssert(resultPlayer?.teamates[1].name != nil)
        XCTAssert(resultPlayer?.teamates[3].fillins?.count == 5)
    }
}
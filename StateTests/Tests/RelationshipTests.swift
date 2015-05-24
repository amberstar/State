import XCTest
import State

class RelationshipTests: Test {

    func makeChildren() -> [TestChild] {
        var children = [TestChild]()
        for index in 0...9 {
            var grandChildren = [Grandchild]()
            
            for index in 0...4 {
                var grandChild = Grandchild(age: index, name: "GrandChild\(index)", gender: Gender.Female)
                grandChildren.append(grandChild)
            }
            var child = TestChild(age: index, name: "Child\(index)", gender: Gender.Male, myChildren: grandChildren)
            children.append(child)
        }
        return children
    }
    
    func makeGrandChildren(var children: [TestChild]) -> [Grandchild] {
        var grandChildren = [Grandchild]()
        
        for child in children {
            grandChildren.extend <*> child.myChildren
        }
        return grandChildren
    }

    func testCodingModelWithOneToMany() {
        var children = makeChildren()
        var grandChildren = makeGrandChildren(children)
        var sampleData = TestRelationships(myChildren: children, myGrandChildren: grandChildren, myOneChild: TestChild(age: 22, name: "Mark", gender: Gender.Male, myChildren: nil))
        JSON.write(Encoder.encodeModel(sampleData), path: tempPathFor("relationship.json"))
        var testData : TestRelationships? = Decoder.decodeModel(JSON.read(tempPathFor("relationship.json")))
        
        XCTAssert(testData != nil)
        XCTAssert(testData?.myChildren?.count == sampleData.myChildren?.count)
        XCTAssert(testData?.myGrandChildren?.count == sampleData.myGrandChildren?.count)
        XCTAssert(testData?.myGrandChildren?[0].name == sampleData.myGrandChildren?[0].name)
        XCTAssert(testData?.myOneChild?.name == sampleData.myOneChild?.name)
        XCTAssert(testData?.myGrandChildren?[0].gender == sampleData.myGrandChildren?[0].gender)
        XCTAssert(testData?.myChildren?[3].age == sampleData.myGrandChildren?[3].age)

    }
    
}
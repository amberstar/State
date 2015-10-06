import XCTest
import STState

class RelationshipTests: Test {

    func makeChildren() -> [TestChild] {
        var children = [TestChild]()
        for index in 0...9 {
            var grandChildren = [Grandchild]()
            
            for index in 0...4 {
                let grandChild = Grandchild(age: index, name: "GrandChild\(index)", gender: Gender.Female)
                grandChildren.append(grandChild)
            }
            let child = TestChild(age: index, name: "Child\(index)",   myChildren: grandChildren, gender: Gender.Male)
            children.append(child)
        }
        return children
    }
    
    func makeGrandChildren(children: [TestChild]) -> [Grandchild] {
        var grandChildren = [Grandchild]()
        
        for child in children {
            if let grandkids = child.myChildren {
                grandChildren.appendContentsOf(grandkids)
            }
        }
        return grandChildren
    }

    func testCodingModelWithOneToMany() {
        let children = makeChildren()
        let grandChildren = makeGrandChildren(children)
        let sampleData = TestRelationships(myChildren: children, myGrandChildren: grandChildren, myOneChild: TestChild(age: 22, name: "Mark", myChildren: nil, gender: Gender.Male ))
        sampleData.save(.JSON, path: tempPathFor("relationship.json"))

        let testData = TestRelationships(.JSON, path:tempPathFor("relationship.json"))
        
        XCTAssert(testData != nil)
        XCTAssert(testData?.myChildren?.count == sampleData.myChildren?.count)
        XCTAssert(testData?.myGrandChildren?.count == sampleData.myGrandChildren?.count)
        XCTAssert(testData?.myGrandChildren?[0].name == sampleData.myGrandChildren?[0].name)
        XCTAssert(testData?.myOneChild?.name == sampleData.myOneChild?.name)
        XCTAssert(testData?.myGrandChildren?[0].gender == sampleData.myGrandChildren?[0].gender)
        XCTAssert(testData?.myChildren?[3].age == sampleData.myGrandChildren?[3].age)
    }
    
    
    func testCodingModelWithDictionaryComposition() {
        var testComposition = TestDictionaryComposition(employees: [String : Employee]())
        let employee1 = Employee(name: "Jane", title: "Manager")
        let employee2 = Employee(name: "John", title: nil)
        testComposition.employees["Jane"] = employee1
        testComposition.employees["John"] = employee2
        testComposition.save(.Plist, path: tempPathFor("test_composition.plist"))
        
        let inTestComposition = TestDictionaryComposition(.Plist, path: tempPathFor("test_composition.plist"))
        
        XCTAssert(inTestComposition != nil)
        XCTAssert(inTestComposition?.employees["Jane"]?.title == "Manager")
    }
}

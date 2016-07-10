import XCTest
import State

class RelationshipTests: Test {

    func makeChildren() -> [TestChild] {
        var children = [TestChild]()
        for index in 0...9 {
            var grandChildren = [Grandchild]()
            
            for index in 0...4 {
                let grandChild = Grandchild(age: index, name: "GrandChild\(index)", gender: Gender.female)
                grandChildren.append(grandChild)
            }
            let child = TestChild(age: index, name: "Child\(index)",   myChildren: grandChildren, gender: Gender.male)
            children.append(child)
        }
        return children
    }
    
    func makeGrandChildren(_ children: [TestChild]) -> [Grandchild] {
        var grandChildren = [Grandchild]()
        
        for child in children {
            if let grandkids = child.myChildren {
                grandChildren.append(contentsOf: grandkids)
            }
        }
        return grandChildren
    }

    func testCodingModelWithOneToMany() {
        let children = makeChildren()
        let grandChildren = makeGrandChildren(children)
        let sampleData = TestRelationships(myChildren: children, myGrandChildren: grandChildren, myOneChild: TestChild(age: 22, name: "Mark", myChildren: nil, gender: Gender.male ))
        _ = sampleData.write(to: tempURLFor("relationship.json"), format: .json)
        
        let testData = TestRelationships(file: tempURLFor("relationship.json"), format: .json)
        
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
        _ = testComposition.write(to: tempURLFor("test_composition.plist"), format: .plist)
        
        let inTestComposition = TestDictionaryComposition(file: tempURLFor("test_composition.plist"), format: .plist)
        XCTAssert(inTestComposition != nil)
        XCTAssert(inTestComposition?.employees["Jane"]?.title == "Manager")
    }
}

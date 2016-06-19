import XCTest


class TestProtocols : Test {

    func testCodingProtocols() {
        let testEmployee = Employee(name: "Test Employee", title: "Manager")
        let testGrandChild = Grandchild(age: 10, name: "Test Grandchild", gender: .male)
        let testChild = TestChild(age: 10, name: "Test Child", myChildren: [testGrandChild, testGrandChild], gender: .male)
        let testConformer1 = TestProtocolConformer(age: 19, ss_number: "12345", isReady: true, employee: testEmployee, children: [testChild, testChild])
        let testConformer2 = TestProtocolConformer2(name: "Test Conformer", ss_number: "1111111")
        let testProtocolContainer = TestProtocolContainter(testProtocol: testConformer1, testProtocols: [testConformer1, testConformer2], testProtocolsDict: ["Conformer 1" : testConformer1, "Conformer 2" : testConformer2])
        
        testProtocolContainer.save(.plist, path: tempPathFor("testProtocol.plist"))
        print(tempPathFor("testProtocol.plist"))
        let inTestProtocolContainer = TestProtocolContainter(.plist, path: tempPathFor("testProtocol.plist"))
        
        XCTAssertNotNil(inTestProtocolContainer)
        
    }
    
    
}

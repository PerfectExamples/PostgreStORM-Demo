//
//  Create.swift
//  PostgreStORM-Demo
//
//  Created by Jonathan Guthrie on 2017-01-04.
//
//

import StORM
import PostgresStORM


/* =============================================================================================
Save - New row
Note that there no id property. This tells the ORM to create a new row, and the closure assigns the id on response.
If you have a non-database-assigned id, you will need to use the "create" method instead.
============================================================================================= */
func saveNew() throws -> User {

	let obj = User()
	obj.firstname = "X"
	obj.lastname = "Y"

	do {
		try obj.save {id in obj.id = id as! Int }
	} catch {
		throw error
	}

	print("Object created with new id of \(obj.id)")
	return obj
}





/* =============================================================================================
Save - New row with code-assigned ID.
============================================================================================= */
func saveCreate() throws -> User {

	// First, we are making absolutely sure this will succeed because we are assigning the ID in code, not in daabase.
	// Therefore we delete any pre-existing row that uses this ID.
	// This is only for demonstration purposes.
	let deleting = User()
	do {
		deleting.id	= 10001
		try deleting.delete()
	} catch {
		throw error
	}


	// Now save a new row, with a code-assigned ID.
	let obj = User()

	do {
		obj.id			= 10001
		obj.firstname	= "Mister"
		obj.lastname	= "PotatoHead"
		obj.email		= "potato@example.com"
		try obj.create()
	} catch {
		throw error
	}

	print("Object created with code-assigned id of \(obj.id)")
	return obj
}


/* =============================================================================================
More "detailed/complex" method... using "insert" directly.
============================================================================================= */
func insertDemo() throws -> User {

	let obj = User()

	var iObj = [String:Any]()
	iObj["firstname"] = "Johnny"
	iObj["lastname"] = "BeGood"
	iObj["email"] = "JohnnyB@example.com"

	do {
		let _ = try obj.insert(iObj)
	} catch {
		throw error
	}

	print("Object created with insert")
	return obj
}

/* =============================================================================================
More "detailed/complex" method... using "insert" directly.
============================================================================================= */
func insertDemoColumns() throws -> User {

	let obj = User()

	do {
		let _ = try obj.insert(cols: ["firstname", "lastname", "email"], params: ["Johnny", "BeGooder", "JohnnyB@example.com"])
	} catch {
		throw error
	}

	print("Object created with insert")
	return obj
}





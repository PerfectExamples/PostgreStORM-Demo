//
//  Select.swift
//  PostgreStORM-Demo
//
//  Created by Jonathan Guthrie on 2017-01-04.
//
//

import StORM
import PostgresStORM




/* =============================================================================================
Get by ID
First, we create a new record, then we fetch it into a new object.
============================================================================================= */
func getByID() throws -> User {

	// Create new row.
	let obj = User()
	obj.firstname = "X"
	obj.lastname = "Y"

	do {
		try obj.save {id in obj.id = id as! Int }
	} catch {
		throw error
	}
	print("Object created with id of \(obj.id), and firstname is \(obj.firstname)")
	// Row is now created.


	// Now we fetch it into anew instance
	let getObj = User()

	// note that the following also works:
	// getObj.id = obj.id
	// then in the do/catch block, 
	// try getObj.get()

	do {
		try getObj.get(obj.id)
	} catch {
		throw error
	}
	print("Object fetched with id of \(getObj.id), and firstname is \(getObj.firstname)")

	return getObj
}


/* =============================================================================================
Find by [String:Any]
First, we create a new record, then we fetch it into a new object.
============================================================================================= */
func findByStringAny() throws -> User {

	// Create new row.
	let obj = User()
	obj.firstname = "FindMe"
	obj.lastname = "Y"

	do {
		try obj.save {id in obj.id = id as! Int }
	} catch {
		throw error
	}
	print("Object created with id of \(obj.id), and firstname is \(obj.firstname)")
	// Row is now created.


	// Now we fetch it into anew instance
	let getObj = User()

	var findObj = [String:Any]()
	findObj["firstname"] = "FindMe"

	do {
		try getObj.find(findObj)
	} catch {
		throw error
	}
	print("Object fetched with id of \(getObj.id), and firstname is \(getObj.firstname)")

	return getObj
}


/* =============================================================================================
Find by SELECT statement
First, we create a new record, then we fetch it into a new object.
============================================================================================= */
func findBySelect() throws -> User {

	// Create new row.
	let obj = User()
	obj.firstname = "FindMe"
	obj.lastname = "Y"

	do {
		try obj.save {id in obj.id = id as! Int }
	} catch {
		throw error
	}
	print("Object created with id of \(obj.id), and firstname is \(obj.firstname)")
	// Row is now created.


	// Now we fetch it into anew instance
	let getObj = User()

	do {
		try getObj.select(whereclause: "firstname = $1", params: ["FindMe"], orderby: ["id"])

		// Inspect the results cursor
		print("Objects fetched with select: found # \(getObj.results.cursorData.totalRecords)")

		// The response is [StORM.StORMRow] in the rows cursor
		print("Objects fetched with select are type StORM.StORMRow: rows \(getObj.results.rows)")

		// loop through found set in cursor
		for row in getObj.rows() {
			print("Object fetched with select: row id \(row.id)")
		}

	} catch {
		throw error
	}

	return getObj
}



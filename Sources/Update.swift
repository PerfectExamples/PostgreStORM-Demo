//
//  Update.swift
//  PostgreStORM-Demo
//
//  Created by Jonathan Guthrie on 2017-01-04.
//
//

import StORM
import PostgresStORM


/* =============================================================================================
Save - Update
First, we create a new record, then we update it.

Note that the only change between the two is that the first time we invoke there is no id property
This tells the ORM to create a new row, and the closure assigns the id on response.
============================================================================================= */
func saveUpdate() throws -> User {

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


	// Now we change it
	obj.firstname = "A"
	obj.lastname = "B"
	do {
		try obj.save()
	} catch {
		throw error
	}
	print("Object created with id of \(obj.id), and firstname is now \(obj.firstname)")
	// ow is now saved, and changed

	return obj
}



// The longer way...
func saveUpdateLongForm() throws -> User {

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


	// Now we change it
	do {
		try obj.update(cols: ["firstname", "lastname", "email"], params: ["Donkey", "Kong", "DonkeyK@example.com"], idName: "id", idValue: obj.id)
	} catch {
		throw error
	}
	print("Object created for long form update with id of \(obj.id)")
	// ow is now saved, and changed

	return obj
}

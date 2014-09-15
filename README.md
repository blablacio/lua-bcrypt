A thin Lua wrapper around the OpenBSD implementation of bcrypt. Note that it
will NOT run on other operating systems.


Requirements
------------

OpenBSD, LuaJIT (the one bundled with OpenResty will do).

Usage
-----

	local bcrypt = require("bcrypt")

	-- generate a salt and pass it to digest
	local salt = bcrypt.salt(5)
	local digest = bcrypt.digest("password", salt)

	assert(bcrypt.verify("password", digest))

	-- pass number of rounds for salt generation instead of salt
	local digest = bcrypt.digest("password", 5)

	assert(bcrypt.verify("password", digest))

	-- pass only key without salt, salt will automatically be generated in 5 rounds and used
	local digest = bcrypt.digest("password")

	assert(bcrypt.verify("password", digest))

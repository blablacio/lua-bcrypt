local ffi = require("ffi")
local ffi_cdef = ffi.cdef
local ffi_str = ffi.string
local C = ffi.C

ffi_cdef[[
char *	bcrypt_gensalt(uint8_t log_rounds);
char *	bcrypt(const char *key, const char *salt);
int	bcrypt_checkpass(const char *pass, const char *goodhash);
]]

local function make_salt(rounds)
  local res = C.bcrypt_gensalt(rounds)
  return ffi_str(res)
end

local _M = {
  _VERSION = "0.01"
}

function _M.salt(rounds)
  return make_salt(rounds) 
end

function _M.digest(key, salt)
  if salt == nil then
    salt = 5
  end
  if type(salt) == "number" then
    salt = make_salt(salt) 
  end
  local res = C.bcrypt(key, salt)
  return ffi_str(res)
end

function _M.verify(pass, hash)
  local res = C.bcrypt_checkpass(pass, hash)
  return res == 0 and true or false
end

return _M


-- SRTO Installer Script
-- Usage: wget run <domain>/install.lua <domain>

local args = {...}
local domain = args[1]

if not domain then
    print("========================================")
    print("SRTO - Installation Error")
    print("========================================")
    print("")
    print("Usage:")
    print("  wget run <domain>/install.lua <domain>")
    print("")
    print("Example:")
    print("  wget run http://example.com:5000/install.lua http://example.com:5000")
    print("========================================")
    return
end

print("========================================")
print("SRTO - Installing...")
print("========================================")
print("")

local wsUrl = domain:gsub("^http://", "ws://"):gsub("^https://", "wss://")

local file = fs.open("domain.txt", "w")
file.write(wsUrl)
file.close()
print("Saved server URL to domain.txt")

if fs.exists("startup.lua") then
    fs.delete("startup.lua")
end

local ok, err = pcall(function()
    shell.run("wget", domain .. "/lua/startup.lua", "startup.lua")
end)

if not ok or not fs.exists("startup.lua") then
    print("Failed to download startup.lua: " .. tostring(err))
    return
end

print("")
print("========================================")
print("SRTO - Installation Complete!")
print("========================================")
print("Server: " .. wsUrl)
print("")
print("Rebooting in 3 seconds...")
sleep(3)
os.reboot()

--// Custom Display Platform by MikeFeng © GPL 3.0 (2025)

if game.PlaceId ~= 6520999642 then return end
local ExecutorName, CoreGui = identifyexecutor and identifyexecutor() or '', game:GetService'CoreGui'
local function Message(Text)
    local Message = Instance.new('Message', CoreGui)
    Message.Text = Text
    task.wait(5)
    Message:Destroy()
end
if not (isfile and readfile and writefile) then return Message(`😩 Incompatible executor '{ExecutorName}'{'\n'}(missing isfile, readfile, writefile)`) end
writefile('FNFRemixDisplayContent.txt', tostring(Content ~= nil and Content or '😇'))
local StarterGui = game:GetService'StarterGui'
local function Alert()
    local Sound = Instance.new('Sound', game:GetService'SoundService')
    Sound.Volume = 2
    Sound.SoundId = 'rbxassetid://4590662766'
    Sound.PlayOnRemove = true
    Sound:Destroy()
end
if _G.FNFRemixACPD or getgenv and getgenv().FNFRemixACPD then
    StarterGui:SetCore('SendNotification', {
        Title = '🧐 Changed Content!',
        Text = `Your display platform Content has been changed to '{Content}', rejoin to see your changes.`,
        Duration = 5
    })
    return Alert()
end
local Players, TPService = game:GetService'Players', game:GetService'TeleportService'
local Speaker, QueueOnTP = Players.LocalPlayer, (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or queue_on_teleport
local Rejoin = Instance.new('BindableFunction')
Rejoin.OnInvoke = function(Answer)
    if Answer == 'Yes' then
        if #Players:GetPlayers() <= 1 then
            Speaker:Kick('\nRejoining...')
            wait()
            TPService:Teleport(6520999642, Speaker)
        else
            TPService:TeleportToPlaceInstance(6520999642, game.JobId, Speaker)
        end
    end
end
if not QueueOnTP then return Message(`😩 Incompatible executor '{ExecutorName}'{'\n'}(missing queue_on_teleport)`) end
task.spawn(function()
    if ExecutorName == 'Xeno' or ExecutorName == 'Solara' then
        Message(`🤧 Your executor '{ExecutorName}' may not work properly.{'\n'}(Your executor will wait for the game to load, which will delay the execution time of queue_on_teleport)`)
    end
end)
QueueOnTP([[
    if game.PlaceId ~= 6520999642 then return end
    local ExecutorName = identifyexecutor and identifyexecutor() or ''
    if not (isfile and readfile) then
        local Message = Instance.new('Message', game:GetService'CoreGui')
        Message.Text = `😩 Your executor '{ExecutorName}' does not support this script\n(missing isfile, readfile)`
        task.wait(5)
        return Message:Destroy()
    end
    local Content, Speaker = (isfile('FNFRemixDisplayContent.txt') and readfile('FNFRemixDisplayContent.txt')) or '😇', game:GetService'Players'.LocalPlayer
    task.spawn(function()
        PreCheck = Speaker:WaitForChild'PlayerScripts'.ChildAdded:Connect(function(Child)
            if Child:IsA'LocalScript' and Child.Name == 'PlatformDisplay' then
                Child.Disabled = true
                print'🤗 Disabled original display platform controller'
                PreCheck:Disconnect()
            end
        end)
    end)
    print'🥱 Waiting for Remote Event'
    game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Content))
    print(`😉 Fire Servered, your display platform was changed to '{Content}'`)
    warn"😨 If the owner BitWork joins your server, you'd better leave the game quickly"
]])
print(`🤫 Would you like to change your display platform Content to '{Content}'?`)
StarterGui:SetCore('SendNotification', {
    Title = '🧐 Rejoin Required!',
    Text = 'Changing your display platform requires you to rejoin. Would you like to rejoin now?',
    Button1 = 'Yes',
    Button2 = 'No',
    Duration = (1 / 0),
    Callback = Rejoin
})
Alert()
if getgenv then
    getgenv().FNFRemixACPD = true
else
    _G.FNFRemixACPD = true
end

--// Custom Display Platform by MikeFeng © GPL 3.0 (2025)

if game.PlaceId == 6520999642 then
    local Cloneref, ExecutorName = cloneref or function(x) return x end, identifyexecutor() or ''
    local CoreGui = Cloneref(game:GetService'CoreGui')
    local function Message(Text)
        local Message = Instance.new('Message', CoreGui)
        Message.Text = Text
        task.wait(5)
        Message:Destroy()
    end
    if not (isfile and readfile and writefile) then
        return Message(`Your executor '{ExecutorName}' does not support this script{'\n'}(missing isfile, readfile, writefile)`)
    end
    writefile('FNFRemixDisplayContext.txt', Context ~= nil and tostring(Context) or '😇')
    local StarterGui = Cloneref(game:GetService'StarterGui')
    local function Notify()
        local Sound = Instance.new('Sound', Cloneref(game:GetService'SoundService'))
        Sound.Volume = 2
        Sound.SoundId = 'rbxassetid://4590662766'
        Sound.PlayOnRemove = true
        Sound:Destroy()
    end
    if _G.FNFRemixACPD or getgenv and getgenv().FNFRemixACPD then
        StarterGui:SetCore('SendNotification', {
            Title = 'Changed Context!',
            Text = `Your display platform context has been changed to '{Context}', rejoin to see your changes.`,
            Duration = 5
        })
        Notify()
    else
        local Players, TPService = Cloneref(game:GetService'Players'), Cloneref(game:GetService'TeleportService')
        local Speaker, QOTP = Players.LocalPlayer, (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or queue_on_teleport
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
        if QOTP then
            task.spawn(function()
                if ExecutorName == 'Xeno' or ExecutorName == 'Solara' then
                    Message(`Your executor '{ExecutorName}' may not be able to successfully change your display platform.{'\n'}(Your executor will wait for the game to load, which will delay the execution time of queue_on_teleport)`)
                end
            end)
            QOTP([[
                if game.PlaceId == 6520999642 then
                    local Cloneref, ExecutorName = cloneref or function(x) return x end, identifyexecutor() or ''
                    if not (isfile and readfile) then
                        Message = Instance.new('Message', Cloneref(game:GetService'CoreGui'))
                        Message.Text = `Your executor '{ExecutorName}' does not support this script\n(missing isfile, readfile)`
                        task.wait(5)
                        return Message:Destroy()
                    end
                    local Context, Speaker = (isfile('FNFRemixDisplayContext.txt') and readfile('FNFRemixDisplayContext.txt')) or '😇', Cloneref(game:GetService'Players').LocalPlayer
                    task.spawn(function()
                        PreCheck = Speaker:WaitForChild'PlayerScripts'.ChildAdded:Connect(function(Child)
                            if Child:IsA'LocalScript' and Child.Name == 'PlatformDisplay' then
                                Child.Disabled = true
                                print'Disabled original display platform controller'
                                PreCheck:Disconnect()
                            end
                        end)
                    end)
                    print'Waiting for Remote Event'
                    Cloneref(game:GetService'ReplicatedStorage'):WaitForChild'Remotes':WaitForChild'PlatformRemoteEvent':FireServer(tostring(Context))
                    print(`Fire Servered, your display platform was changed to '{Context}'`)
                end
            ]])
            StarterGui:SetCore('SendNotification', {
                Title = 'Rejoin Required!',
                Text = 'Changing your display platform requires you to rejoin. Would you like to rejoin now?',
                Button1 = 'Yes',
                Button2 = 'No',
                Duration = (1 / 0),
                Callback = Rejoin
            })
            Notify()
            if getgenv then
                getgenv().FNFRemixACPD = true
            else
                _G.FNFRemixACPD = true
            end
        else
            Message(`Incompatible executor '{ExecutorName}'{'\n'}(missing queue_on_teleport)`)
        end
    end
end

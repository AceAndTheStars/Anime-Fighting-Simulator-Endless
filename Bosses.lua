-- Bosses.lua | AFSE Modular Script

return function(Tabs, Fluent)

    Tabs.Bosses:AddParagraph({
        Title = "Bosses Section",
        Content = "Auto-farm Riru & Pain for limited champions."
    })

    -- Damage Method Selector
    local selectedDamageMethod = "Strength"  -- Default
    local swordActivated = false

    Tabs.Bosses:AddDropdown("DamageMethod", {
        Title = "Damage Method",
        Description = "Choose how to deal damage to bosses",
        Values = {"Strength", "Sword"},
        Default = "Strength",
        Callback = function(value)
            if value == "Sword" and selectedDamageMethod ~= "Sword" then
                swordActivated = false
            end
            selectedDamageMethod = value
            Fluent:Notify({
                Title = "Damage Method",
                Content = "Now using: " .. value,
                Duration = 4
            })
        end
    })

    -- Auto Farm Riru Toggle
    local AutoFarmRiruEnabled = false

    Tabs.Bosses:AddToggle("AutoFarmRiru", {
        Title = "Auto Farm Riru",
        Description = "Automatically farms Riru using selected damage method",
        Default = false,
        Callback = function(state)
            AutoFarmRiruEnabled = state

            if state then
                swordActivated = false

                Fluent:Notify({
                    Title = "Auto Farm Riru",
                    Content = "Enabled — Farming Riru with " .. selectedDamageMethod,
                    Duration = 6
                })

                spawn(function()
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
                    local RemoteEvent = Remotes:WaitForChild("RemoteEvent")

                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer

                    local targetPosition = Vector3.new(-960.308, 61.000, 322.086)
                    local teleportCFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))

                    while AutoFarmRiruEnabled do
                        pcall(function()
                            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                            local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

                            root.CFrame = teleportCFrame

                            if selectedDamageMethod == "Strength" then
                                RemoteEvent:FireServer("Train", 1)
                            elseif selectedDamageMethod == "Sword" then
                                if not swordActivated then
                                    RemoteEvent:FireServer("ActivateSword")
                                    swordActivated = true
                                end
                                RemoteEvent:FireServer("Train", 4)
                            end
                        end)

                        wait(0.25)
                    end
                end)
            else
                swordActivated = false

                Fluent:Notify({
                    Title = "Auto Farm Riru",
                    Content = "Disabled",
                    Duration = 4
                })
            end
        end
    })

    -- Auto Farm Pain Toggle (NEW)
    local AutoFarmPainEnabled = false

    Tabs.Bosses:AddToggle("AutoFarmPain", {
        Title = "Auto Farm Pain",
        Description = "Automatically farms Pain using selected damage method",
        Default = false,
        Callback = function(state)
            AutoFarmPainEnabled = state

            if state then
                swordActivated = false

                Fluent:Notify({
                    Title = "Auto Farm Pain",
                    Content = "Enabled — Farming Pain with " .. selectedDamageMethod,
                    Duration = 6
                })

                spawn(function()
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
                    local RemoteEvent = Remotes:WaitForChild("RemoteEvent")

                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer

                    -- Pain's exact world pivot converted to CFrame
                    local painCFrame = CFrame.new(
                        1240.30603, 145.097107, -970.138977,
                        0.292524338, -0, -0.956258118,
                        0, 1, -0,
                        0.956258118, 0, 0.292524338
                    )
                    local teleportCFrame = painCFrame + Vector3.new(0, 5, 0)  -- Slight height offset

                    while AutoFarmPainEnabled do
                        pcall(function()
                            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                            local root = character:FindFirstChild("HumanoidRootPart") or character:WaitForChild("HumanoidRootPart")

                            root.CFrame = teleportCFrame

                            if selectedDamageMethod == "Strength" then
                                RemoteEvent:FireServer("Train", 1)
                            elseif selectedDamageMethod == "Sword" then
                                if not swordActivated then
                                    RemoteEvent:FireServer("ActivateSword")
                                    swordActivated = true
                                end
                                RemoteEvent:FireServer("Train", 4)
                            end
                        end)

                        wait(0.25)
                    end
                end)
            else
                swordActivated = false

                Fluent:Notify({
                    Title = "Auto Farm Pain",
                    Content = "Disabled",
                    Duration = 4
                })
            end
        end
    })

end
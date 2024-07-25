wait(1.5)

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Group = 34504784

local PlaceID = game.PlaceId
local JobID = game.JobId

local Player = Players.LocalPlayer
local Backpack = Player.Backpack
local Mouse = Player:GetMouse()

local Character = Player.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local Animator = Humanoid:FindFirstChildOfClass("Animator")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local Cooldown = {}

local Katana

if Player:IsInGroup(Group) and Player:GetRankInGroup(Group) >= 50 then
	if Player:WaitForChild("Information"):FindFirstChild("Streaks").Value >= 5 then
		local MainRemote = ReplicatedStorage:WaitForChild("MainRemote")

		Katana = Player.Backpack:FindFirstChild("[Katana]") or Character:FindFirstChild("[Katana]")

		if not Katana then
			local OldCFrame

			OldCFrame = HumanoidRootPart.CFrame

			HumanoidRootPart.CFrame = workspace.Ignored.Shop.Others:FindFirstChild("[Katana] - $1200").PrimaryPart.CFrame

			wait(0.5)

			fireclickdetector(workspace.Ignored.Shop.Others:FindFirstChild("[Katana] - $1200").ClickDetector)

			wait(0.5)

			HumanoidRootPart.CFrame = OldCFrame

			Katana = Player.Backpack:FindFirstChild("[Katana]") or Character:FindFirstChild("[Katana]")
		end

		local Grip = CFrame.new(-0.012, -0.009, -0.147) * CFrame.fromOrientation(math.rad(-82.902), math.rad(158.562), math.rad(-159.599))
		Katana.Grip = Grip

		Katana.Hitbox.Size = Vector3.new(20, 20, 20)

		function PlaySFX(Event, SoundID)
			local LastTool

			for i, v in pairs(Character:GetDescendants()) do
				if v:IsA("Tool") then
					LastTool = v
					v.Parent = Backpack
				end
			end

			Backpack["[Boombox]"].Parent = Character

			ReplicatedStorage:WaitForChild("MainRemote"):FireServer(Event, SoundID)
			ReplicatedStorage:WaitForChild("MainRemote"):FireServer("Remove")

			if Character:FindFirstChild("[Boombox]") then
				Character:WaitForChild("[Boombox]").Parent = Backpack
			end

			if LastTool.Parent ~= Character then
				LastTool.Parent = Character
			end
		end

		function CreateValue(Parent, Name, Value)
			local StringValue = Instance.new("StringValue")
			StringValue.Name = Name
			StringValue.Value = Value
			StringValue.Parent = Parent
		end

		local function CreateAnimation(AnimationID, Animator)
			if (tonumber(AnimationID) and Animator ~= nil) then
				local AnimationLoad = Instance.new("Animation")
				AnimationLoad.AnimationId = "rbxassetid://" .. AnimationID

				local Animation = Animator:LoadAnimation(AnimationLoad)

				return Animation
			end
		end

		local Idle = CreateAnimation(16679109994, Animator)
		local Run = CreateAnimation(14776847416, Animator)
		local BackDash = CreateAnimation(17343591146, Animator)
		local Roll = CreateAnimation(14776851977, Animator)
		local TpAnimation = CreateAnimation(15816573842, Animator)
		local Demonic = CreateAnimation(15230200521, Animator)

		Mouse.KeyDown:Connect(function(Keybind)
			if Character:FindFirstChild(Katana.Name) then
				local LookVector = HumanoidRootPart.CFrame.LookVector
				local Dash = HumanoidRootPart.Position + LookVector * 30

				if Keybind == "r" then
					if Cooldown[Player.UserId] ~= true then
						Cooldown[Player.UserId] = true

						spawn(function()
							wait(0.5)
							Cooldown[Player.UserId] = false
						end)

						Character:MoveTo(Dash)

						PlaySFX("Play", 163621622)
					end
				end

				if Keybind == "z" then
					local LookVector = Character.HumanoidRootPart.CFrame.LookVector
					LookVector = Vector3.new(LookVector.X, LookVector.Y + 0.55, LookVector.Z)

					local BodyVelocity = Instance.new("BodyVelocity", Character.LowerTorso)
					BodyVelocity.Name = "N/A_S"
					BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					BodyVelocity.Velocity = LookVector * 125

					Debris:AddItem(BodyVelocity, 0.2)

					Roll:Play()
				end

				if Keybind == "t" then
					if Cooldown[Player.UserId] ~= true then
						Cooldown[Player.UserId] = true

						local Distance = (HumanoidRootPart.Position - Mouse.Hit.p).magnitude

						if Distance <= 500 then
							HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p)
							TpAnimation:Play()
							PlaySFX("Play", 5772362759)
						end

						wait(0.5)

						Cooldown[Player.UserId] = false
					end
				end

				if Keybind == "c" then
					local BodyPosition = Instance.new("BodyPosition")
					BodyPosition.Parent = Character.UpperTorso 
					BodyPosition.Position = HumanoidRootPart.CFrame * Vector3.new(0, 0, 100)
					BodyPosition.D = 2000

					BackDash:Play()
					BackDash:AdjustSpeed(0.2)
					BackDash.TimePosition = 10 

					wait(1)

					BackDash:Stop(0.2)

					BodyPosition:Destroy()
				end

				if Keybind == "l" then
					if Cooldown[Player.UserId] ~= true then
						Cooldown[Player.UserId] = true
						local Speed = 0

						for i = 1, 180 do
							Speed += 1
							Katana.Grip *= CFrame.Angles(0, 0, math.rad(Speed))
							Katana.Parent = Player.Backpack
							Katana.Parent = Character
							wait()
						end

						Katana.Grip = Grip

						wait(1)

						Cooldown[Player.UserId] = false
					end
				end

				if Keybind == "k" then
					if Cooldown[Player.UserId] ~= true then
						Cooldown[Player.UserId] = true

						local BodyPosition = Instance.new("BodyPosition")
						BodyPosition.Parent = Character:FindFirstChild("LowerTorso")
						BodyPosition.Name = "N/A_S"
						BodyPosition.Position = HumanoidRootPart.CFrame * Vector3.new(0, 200, 0)
						BodyPosition.D = 2000

						local Animation = CreateAnimation(12842028530, Animator)
						Animation:Play()

						if Katana.Parent ~= Character then
							Humanoid:EquipTool(Katana)
						end

						Katana:Activate()

						PlaySFX("Play", 8317719384)

						for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
							if v.Animation.AnimationId == "rbxassetid://14776835565" then
								v:Stop()
							end
						end

						wait(1.25)

						Animation:Stop()
						BodyPosition:Destroy()

						local XD = CreateAnimation(12842045781, Animator)
						XD:Play(nil, nil, 0.8)

						TweenService:Create(HumanoidRootPart, TweenInfo.new(0.010, Enum.EasingStyle.Linear), {CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0, 1.5, 0))}):Play()

						wait(2)

						Cooldown[Player.UserId] = false
					end
				end

				if Keybind == "y" then
					if Cooldown[Player.UserId] ~= true then
						Cooldown[Player.UserId] = true

						local Victims = {}

						for i, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
							v:Stop()
						end

						wait(0.1)

						Demonic:Play()
						PlaySFX("Play", 13951554708)

						local BodyPosition = Instance.new("BodyPosition")
						BodyPosition.Parent = Character:FindFirstChild("LowerTorso")
						BodyPosition.Name = "N/A_S"
						BodyPosition.Position = HumanoidRootPart.CFrame * Vector3.new(0, 50, 0)
						BodyPosition.D = 2000

						Katana.Parent = Backpack

						spawn(function()
							wait(7)

							BodyPosition:Destroy()
							Demonic:Stop()

							for i, v in pairs(workspace.Characters:GetChildren()) do
								if v:FindFirstChild("HumanoidRootPart") then
									local RootPart = v:FindFirstChild("HumanoidRootPart")

									if (RootPart.Position - HumanoidRootPart.Position).Magnitude <= 50 then
										if Katana.Parent ~= Character then
											Humanoid:EquipTool(Katana)
										end

										Katana:Activate()

										task.wait(0.5)

										HumanoidRootPart.CFrame = CFrame.new(RootPart.Position)

										wait(1)
									end
								end
							end
						end)

						wait(1)

						Cooldown[Player.UserId] = false
					end
				end
			end
		end)

		spawn(function()
			while true do
				if Humanoid then
					if Character:FindFirstChild(Katana.Name) then
						if Humanoid.MoveDirection.Magnitude == 0 then
							if not Idle.IsPlaying then
								Idle:Play()
								Run:Stop()
							end
						else
							if not Run.IsPlaying then
								Idle:Stop()
								Run:Play()
								Run:AdjustSpeed(1.5)
							end
						end
					else
						Idle:Stop()
						Run:Stop()
					end
				end
				wait()
			end
		end)

		Katana.Equipped:Connect(function()
			if not Character:FindFirstChild("KatanaWalk") then
				CreateValue(Character, "KatanaWalk", "Default")
			end

			if not Character:FindFirstChild("Speed_DEBUG") then
				CreateValue(Character, "Speed_DEBUG", "Default")
			end
		end)

		Katana.Unequipped:Connect(function()
			if Character:FindFirstChild("KatanaWalk") then
				Character:FindFirstChild("KatanaWalk"):Destroy()
			end

			if Character:FindFirstChild("Speed_DEBUG") then
				Character:FindFirstChild("Speed_DEBUG"):Destroy()
			end
		end)
	else
		Player:Kick(Player.Name .. " | " .. Player.UserId .. " | Is Not Whitelisted To Use The Script")
	end
end

wait(1)

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

if Player:IsInGroup(Group) and Player:GetRankInGroup(Group) >= 50 then
	local RequiemOn = false
	local OldColor = nil
	local OldTransparency = nil
	
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
	
	local Run = CreateAnimation(14777024220, Animator)
	
	local WalkSound = Instance.new("Sound", HumanoidRootPart)
	WalkSound.Volume = 1
	WalkSound.SoundId = "rbxassetid://1244506786"
	WalkSound.Looped = true
	
	Player.Chatted:Connect(function(Msg)
		if Msg == "Shadow Requiem!" and RequiemOn == false then
			RequiemOn = true
			
			for i, v in pairs(Character:GetDescendants()) do
				if v:IsA("BasePart") and v.Name ~= "LaserArm" or v.Name ~= "HumanoidRootPart" then
					OldColor = v.Color
					OldTransparency = v.Transparency
					
					v.Color = Color3.fromRGB(0, 0, 0)
					v.Transparency = 0.95
				end
			end
		elseif Msg == "Stop Requiem!" and RequiemOn == true then
			RequiemOn = false
			
			for i, v in pairs(Character:GetDescendants()) do
				if v:IsA("BasePart") and v.Name ~= "LaserArm" or v.Name ~= "HumanoidRootPart" then
					v.Color = OldColor
					v.Transparency = OldColor
				end
			end
		end
	end)
	
	RunService.Heartbeat:Connect(function()
		local CurrentWS = Humanoid.WalkSpeed
		
		if RequiemOn == true then
			if Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
				Run:Stop()
				WalkSound:Stop()
			else
				local Final = CurrentWS / 10
				Run:Play(nil, nil, Final)
				WalkSound.PlaybackSpeed = Final
				WalkSound:Play()
			end
		end
		
		wait()
	end)
else
	Player:Kick(Player.Name .. " | " .. Player.UserId .. " | Is Not Whitelisted To Use The Script")
end

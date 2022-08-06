local service = setmetatable({}, {
	__index = function(t, k)
		return game:GetService(k)
	end
})

if service.CoreGui:FindFirstChild("DrSTaTTiK") then
	service.CoreGui:FindFirstChild("DrSTaTTiK"):Destroy()
end

function Create(cls,props)
	local inst = Instance.new(cls)
	for i,v in pairs(props) do
		inst[i] = v
	end
	return inst
end

local Main = Create("ScreenGui",{Parent=service.CoreGui,Name="DrSTaTTiK"})
local Open = Create("TextButton",{Parent=Main,Size=UDim2.new(0,40,0,20),Position=UDim2.new(.5,-20,.85,-5),Text="Open",BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(238, 238, 238),ZIndex=2})


local Settings = {
	["WalkSpeed"] 			= 16;
	["JumpPower"]			= 0;
	["GUIOpened"]			= false;
	["Hitbox"]				= false;
	["Doors"]				= false;
}

local WayPoints = {
	["dclass"] 				= CFrame.new(-180, 22, -161);
	["guard"] 				= CFrame.new(-165, 0, -357);
	["exit"] 				= CFrame.new(-424, 190, -200);
	["mtf"] 				= CFrame.new(-401, 210, -408);
	["CI"] 					= CFrame.new(-20, 190, -639);
	["gateA"] 				= CFrame.new(-79,9,-530);
	["gateB"] 				= CFrame.new(-343, 9, -332);
	["s914"] 				= CFrame.new(64, 9, -46);
}

local MainMenus={}

function MakeShadow(UI,Index)
	Create("Frame",{Parent=UI,Size=UDim2.new(1,0,1,0),ZIndex=Index,Position=UDim2.new(0,1,0,1),BackgroundColor3=Color3.fromRGB(0,0,0),BorderSizePixel=0,Transparency=0.9,Name="Shadow"})
	Create("Frame",{Parent=UI,Size=UDim2.new(1,0,1,0),ZIndex=Index,Position=UDim2.new(0,2,0,2),BackgroundColor3=Color3.fromRGB(0,0,0),BorderSizePixel=0,Transparency=0.9,Name="Shadow"})
	Create("Frame",{Parent=UI,Size=UDim2.new(1,0,1,0),ZIndex=Index,Position=UDim2.new(0,3,0,3),BackgroundColor3=Color3.fromRGB(0,0,0),BorderSizePixel=0,Transparency=0.9,Name="Shadow"})
end

function ToggleButton(OnSettings, OffSettings, Operation, Parent, Position, Title)
	local OnColor = OnSettings.Color
	local OnText = OnSettings.Text
	
	local OffColor = OffSettings.Color
	local OffText = OffSettings.Text
	
	local Button = Create("TextButton",{Parent=Parent,Size=UDim2.new(0,40,0,20),Position=Position,Text=OffText,BorderSizePixel=0,BackgroundColor3=OffColor,ZIndex=2})
	local Name = Create("TextLabel",{Parent=Button,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,-1,0),TextColor3=Color3.fromRGB(250,250,250),BackgroundTransparency=1,ZIndex=5,Text=Title})
	local Off = true
	MakeShadow(Button,1)
	
	Button.MouseButton1Click:Connect(function()
		if Off then
			Off = false
			Button.BackgroundColor3 = OnColor
			Button.Text = OnText
			Operation(true)
		else
			Off = true
			Button.BackgroundColor3 = OffColor
			Button.Text = OffText
			Operation(false)
		end
	end)
end

function VariableText(Default, Operation, Parent, Position, Title)
	local TextButton = Create("TextBox",{Parent=Parent,Size=UDim2.new(0,50,0,20),Position=Position,BorderSizePixel=0,Text=Default,ZIndex=3})
	local Name = Create("TextLabel",{Parent=TextButton,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,-1,0),TextColor3=Color3.fromRGB(250,250,250),BackgroundTransparency=1,ZIndex=5,Text=Title})
	MakeShadow(TextButton,1)
	spawn(function()
		Operation(TextButton)
	end)
end

function CreateWindow(Size,Position,Color,Name,Texture,HasMinimize,HasExit)
	local TopBar = Create("Frame",{Parent=Main,Size=UDim2.new(Size.X.Scale,Size.X.Offset,Size.Y.Scale,20),BackgroundColor3=Color,Position=Position,BorderSizePixel=0,ZIndex=3,Active=true,Draggable=true,Visible=false})
	local Menu = Create("ImageLabel",{Parent=TopBar,Size=UDim2.new(Size.X.Scale,Size.X.Offset,Size.Y.Scale,Size.Y.Offset-20),Image=Texture,Position=UDim2.new(0,0,1,0),ScaleType="Tile",ImageColor3=Color3.fromRGB(100,100,100),TileSize=UDim2.new(0,50,0,50),BorderSizePixel=0,ZIndex=2})
	local Name = Create("TextLabel",{Parent=TopBar,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,10,0,0),TextColor3=Color3.fromRGB(250,250,250),BackgroundTransparency=1,ZIndex=5,TextXAlignment="Left",Text=Name})
	if HasMinimize and HasExit then
		Create("TextButton",{Parent=TopBar,Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Text="X",ZIndex=10}).MouseButton1Click:Connect(function()
			Settings.GUIOpened = false
			Open.Visible=true
			for i,v in pairs(MainMenus) do
				v.Visible=false
			end
		end)
		Create("TextButton",{Parent=TopBar,Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-40,0,0),BackgroundTransparency=1,Text="_",ZIndex=10}).MouseButton1Click:Connect(function()
			if Menu.Visible then
				Menu.Visible=false
			else
				Menu.Visible=true
			end
		end)
	elseif HasMinimize and not HasExit then
		Create("TextButton",{Parent=TopBar,Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Text="_",ZIndex=10}).MouseButton1Click:Connect(function()
			if Menu.Visible then
				Menu.Visible=false
			else
				Menu.Visible=true
			end
		end)
	elseif not HasMinimize and HasExit then
		Create("TextButton",{Parent=TopBar,Size=UDim2.new(0,20,1,0),Position=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Text="X",ZIndex=10}).MouseButton1Click:Connect(function()
			Settings.GUIOpened = false
			Open.Visible=true
			for i,v in pairs(MainMenus) do
				v.Visible=false
			end
		end)
	end
	MakeShadow(TopBar,2)
	MakeShadow(Menu,1)
	MainMenus[#MainMenus+1]=TopBar
	return Menu
end

function Teleport(Pos)
	service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
end

function UpdatePlayerList(Table, List, Operation)
	for i,v in pairs(Table) do
		i=i-1
		spawn(function()
			repeat wait() until v.Character
			if v.Character then
				List.CanvasSize=UDim2.new(0,0,0,30*i)
				local button = Create("TextButton",{Parent=List,Text=v.Name,Size=UDim2.new(1,0,0,20),ZIndex=4,BorderSizePixel=0,Position=UDim2.new(0,0,0,30*i)})
				--MakeShadow(button,3)
				button.MouseButton1Click:Connect(function()
					Operation(v)
				end)
			end
		end)
	end
end

function UpdateWaypointList(Table, List, Operation)
	local num = 0
	for key,value in next, Table do
		List.CanvasSize=UDim2.new(0,0,0,30*num)
		local button = Create("TextButton",{Parent=List,Text=key,Size=UDim2.new(1,0,0,20),ZIndex=4,BorderSizePixel=0,Position=UDim2.new(0,0,0,30*num)})
		--MakeShadow(button,3)
		button.MouseButton1Click:Connect(function()
			Operation(value)
		end)
		num=num+1
	end
end

function UpdateGiveList(Table, List, Operation)
	local num = 0
	for i,v in pairs(Table) do
		if v.Name == "Object" or v.Name == "Worldmodel" then
			if v:FindFirstChild("BillboardGui") then
				List.CanvasSize=UDim2.new(0,0,0,30*num)
				local button = Create("TextButton",{Parent=List,Text=v.BillboardGui.TextLabel.Text,Size=UDim2.new(1,0,0,20),ZIndex=6,BorderSizePixel=0,Position=UDim2.new(0,0,0,30*num)})
				--MakeShadow(button,3)
				button.MouseButton1Click:Connect(function()
					Operation(v)
				end)
				num=num+1
			end
		end
	end
end


function UpdateAmmoList(Table, List, Operation)
	local num = 0
	for i,v in pairs(Table) do
		if v.Name == "Ammo" then
			if v:FindFirstChild("BillboardGui") then
				List.CanvasSize=UDim2.new(0,0,0,30*num)
				local button = Create("TextButton",{Parent=List,Text=v.BillboardGui.TextLabel.Text,Size=UDim2.new(1,0,0,20),ZIndex=6,BorderSizePixel=0,Position=UDim2.new(0,0,0,30*num)})
				--MakeShadow(button,3)
				button.MouseButton1Click:Connect(function()
					Operation(v)
				end)
				num=num+1
			end
		end
	end
end

function UpdateTeamList(Table, List, Operation)
	local num = 0
	for i,v in pairs(Table) do
		List.CanvasSize=UDim2.new(0,0,0,30*num)
		local button = Create("TextButton",{Parent=List,Text=v.Name,Size=UDim2.new(1,0,0,20),ZIndex=4,BorderSizePixel=0,Position=UDim2.new(0,0,0,30*num)})
		--MakeShadow(button,3)
		button.MouseButton1Click:Connect(function()
			Operation(v)
		end)
		num=num+1
	end
end

--Setting up window frames
do
	local PlayerMods = CreateWindow(UDim2.new(0,150,0,250),UDim2.new(.5,-75,0,10),Color3.fromRGB(30,144,255),"MadeBy: DrSTaTTiK","rbxassetid://585867512",true,true)
	local PlayerTp = CreateWindow(UDim2.new(0,125,0,250),UDim2.new(.5,85,0,10),Color3.fromRGB(30,144,255),"Player Positions","rbxassetid://585867512",true,false)
	local PlayerTpList = Create("ScrollingFrame",{Parent=PlayerTp,Size=UDim2.new(.9,0,.95,0),Position=UDim2.new(.05,0,.025,0),BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
	local Give = CreateWindow(UDim2.new(0,125,0,250),UDim2.new(.5,-210,0,10),Color3.fromRGB(30,144,255),"Obtain Item","rbxassetid://585867512",true,false)
	local GiveList = Create("ScrollingFrame",{Parent=Give,Size=UDim2.new(.9,0,.95,0),Position=UDim2.new(.05,0,.025,0),BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
	local Team = CreateWindow(UDim2.new(0,125,0,250),UDim2.new(.5,220,0,10),Color3.fromRGB(30,144,255),"Team Switch","rbxassetid://585867512",true,false)
	local TeamList = Create("ScrollingFrame",{Parent=Team,Size=UDim2.new(.9,0,.95,0),Position=UDim2.new(.05,0,.025,0),BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
	local Waypoints = CreateWindow(UDim2.new(0,125,0,250),UDim2.new(.5,-345,0,10),Color3.fromRGB(30,144,255),"Waypoints","rbxassetid://585867512",true,false)
	local WaypointsList = Create("ScrollingFrame",{Parent=Waypoints,Size=UDim2.new(.9,0,.95,0),Position=UDim2.new(.05,0,.025,0),BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
	local Ammo = CreateWindow(UDim2.new(0,125,0,250),UDim2.new(.5,-480,0,10),Color3.fromRGB(30,144,255),"Obtain Ammo","rbxassetid://585867512",true,false)
	local AmmoList = Create("ScrollingFrame",{Parent=Ammo,Size=UDim2.new(.9,0,.95,0),Position=UDim2.new(.05,0,.025,0),BorderSizePixel=0,BackgroundTransparency=1,ScrollBarThickness=2,CanvasSize=UDim2.new(0,0,0,0),ZIndex=5})
	
	--Setting up button functions
	do
		--ToggleButton(OnSettings, OffSettings, Operation, Parent, Position, Title)
		local HitboxSize = Create("TextBox",{Parent=PlayerMods,Size=UDim2.new(0,50,0,20),Position=UDim2.new(0.5,-25,0,50),BorderSizePixel=0,Text="8",ZIndex=3})
		MakeShadow(HitboxSize,1)
		local HitboxMod = ToggleButton(
			{
				Color = Color3.fromRGB(0,128,0),
				Text = "On"
			},
			{
				Color = Color3.fromRGB(128,0,0),
				Text = "Off"
			},
			function(Enabled)
				Settings.Hitbox = Enabled
				if not Settings.Hitbox then
					for i,v in pairs(service.Players:GetPlayers()) do
						if not v.Name ~= service.Players.LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
							local HRP = v.Character.HumanoidRootPart
							HRP.Size = Vector3.new(2, 1.8, 1)
							HRP.Transparency = 1
						end
					end
				end
				while Settings.Hitbox do
					for i,v in pairs(service.Players:GetPlayers()) do
						if v.Name ~= service.Players.LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
							local HRP = v.Character.HumanoidRootPart
							local Size = tonumber(HitboxSize.Text)
							HRP.Size = Vector3.new(Size,Size,Size)
							HRP.Transparency = 0.5
							HRP.Color = Color3.fromRGB(0,0,125)
							HRP.CanCollide = false
						end
					end
					wait()
				end
			end,
			HitboxSize,
			UDim2.new(0,5,-1,-5),
			"Hitbox Mod"
		)
		
		local FullBright = ToggleButton(
			{
				Color = Color3.fromRGB(0,128,0),
				Text = "On"
			},
			{
				Color = Color3.fromRGB(128,0,0),
				Text = "Off"
			},
			function(Enabled)
				Settings.Hitbox = Enabled
				if not Settings.Hitbox then
					service.Lighting.FogEnd = 100
					service.Lighting.Brightness = 0.1
					service.Lighting.ExposureCompensation = 0
					service.Lighting.GlobalShadows = true
				end
				while Settings.Hitbox do
					service.Lighting.FogEnd = -1
					service.Lighting.Brightness = 2
					service.Lighting.ExposureCompensation = 0.5
					service.Lighting.GlobalShadows = false
					wait()
				end
			end,
			PlayerMods,
			UDim2.new(0.5,-20,.6,35),
			"Full Bright"
		)
		
		--[[local OpenAllDoors = ToggleButton(
			{
				Color = Color3.fromRGB(0,128,0),
				Text = "On"
			},
			{
				Color = Color3.fromRGB(128,0,0),
				Text = "Off"
			},
			function(Enabled)
				Settings.Doors = Enabled
				if not Settings.Doors then
					--hmmstve
				end
				while Settings.Doors do
					for _,v in pairs(service.Workspace.FunctionalDoors:GetChildren()) do
						spawn(function()
							v.Config.DetectEvent:FireServer()
						end)
					end
					wait()
				end
			end,
			PlayerMods,
			UDim2.new(0.5,-20,.6,70),
			"Open Doors"
		)]]
	end	
	--Setting things up
	do 
		Open.MouseButton1Click:Connect(function()
			if not Settings.GUIOpened then
				Open.Visible=false
				Settings.GUIOpened = true
				for i,v in pairs(MainMenus) do
					v.Visible=true
				end
			end
		end)
		
		--VariableText(Operation, Parent, Position, Title)
		local WalkSpeed = VariableText(
			16,
			function(TextButton)
				TextButton.Changed:Connect(function()
					Settings.WalkSpeed=tonumber(TextButton.Text)
					if service.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
						service.Players.LocalPlayer.Character.Humanoid.WalkSpeed=Settings.WalkSpeed
					end
				end)
				spawn(function()
					while wait() do
						if service.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
							service.Players.LocalPlayer.Character.Humanoid.WalkSpeed=Settings.WalkSpeed
						end
					end
				end)
			end,
			PlayerMods,
			UDim2.new(0.5,-25,0,90),
			"Walkspeed"
		)	
		local JumpPower = VariableText(
			0,
			function(TextButton)
				TextButton.Changed:Connect(function()
					Settings.JumpPower=tonumber(TextButton.Text)
					if service.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
						service.Players.LocalPlayer.Character.Humanoid.JumpPower=Settings.JumpPower
					end
				end)
				spawn(function()
					while wait() do
						if service.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
							service.Players.LocalPlayer.Character.Humanoid.JumpPower=Settings.JumpPower
						end
					end
				end)
			end,
			PlayerMods,
			UDim2.new(0.5,-25,0,130),
			"Jumppower"
		)	
		
		UpdateWaypointList(
			WayPoints,
			WaypointsList,
			function(pos)
				Teleport(pos)
			end)
		
		UpdatePlayerList(
			service.Players:GetPlayers(),
			PlayerTpList,
			function(Player)
				Teleport(Player.Character.PrimaryPart.CFrame*CFrame.new(0,5,0))
			end)
		service.Players.PlayerAdded:Connect(function()
			PlayerTpList:ClearAllChildren()
			UpdatePlayerList(
				service.Players:GetPlayers(),
				PlayerTpList,
				function(Player)
					Teleport(Player.Character.PrimaryPart.CFrame*CFrame.new(0,5,0))
				end)
		end)
		service.Players.PlayerRemoving:Connect(function()
			PlayerTpList:ClearAllChildren()
			UpdatePlayerList(
				service.Players:GetPlayers(),
				PlayerTpList,
				function(Player)
					Teleport(Player.Character.PrimaryPart.CFrame*CFrame.new(0,5,0))
				end)
		end)
		
		UpdateGiveList(
			service.Workspace:GetChildren(),
			GiveList,
			function(Item)
				Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
		end)
		UpdateAmmoList(
			service.Workspace:GetChildren(),
			AmmoList,
			function(Item)
				Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
		end)
		service.Workspace.ChildAdded:Connect(function(obj)
			if obj.Name == "Object" or obj.Name == "Worldmodel" then
				GiveList:ClearAllChildren()
				UpdateGiveList(
					service.Workspace:GetChildren(),
					GiveList,
					function(Item)
						Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
				end)
			elseif obj.Name == "Ammo" then
				AmmoList:ClearAllChildren()
				UpdateAmmoList(
					service.Workspace:GetChildren(),
					AmmoList,
					function(Item)
						Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
				end)
			end
		end)
		service.Workspace.ChildRemoved:Connect(function(obj)
			if obj.Name == "Object" or obj.Name == "Worldmodel" then
				GiveList:ClearAllChildren()
				UpdateGiveList(
					service.Workspace:GetChildren(),
					GiveList,
					function(Item)
						Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
				end)
			elseif obj.Name == "Ammo" then
				AmmoList:ClearAllChildren()
				UpdateAmmoList(
					service.Workspace:GetChildren(),
					AmmoList,
					function(Item)
						Item.CFrame = service.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,-2)
				end)
			end
		end)
		
		UpdateTeamList(
			service.Teams:GetChildren(),
			TeamList,
			function(Item)
				game:GetService("ReplicatedStorage").ChangeTeam:InvokeServer(Item.Name)
			end)
		service.Teams.ChildAdded:Connect(function(obj)
			TeamList:ClearAllChildren()
			UpdateTeamList(
				service.Teams:GetChildren(),
				TeamList,
				function(Item)
					game:GetService("ReplicatedStorage").ChangeTeam:InvokeServer(Item.Name)
				end)
		end)
		service.Teams.ChildRemoved:Connect(function(obj)
			TeamList:ClearAllChildren()
			UpdateTeamList(
				service.Teams:GetChildren(),
				TeamList,
				function(Item)
					game:GetService("ReplicatedStorage").ChangeTeam:InvokeServer(Item.Name)
				end)
		end)
	end
	spawn(function()
		while wait() do
			service.Players.LocalPlayer.CameraMode = "Classic"
		end
	end)
end

local Module = {}

-- Variable:

local tweenservice = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)

-- Instances:

local ScreenGui = game:GetService("CoreGui"):FindFristChild("NotificationUI") or Instance.new("ScreenGui")
local Index = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

--Properties:

ScreenGui.Name = "NotificationUI"
ScreenGui.Parent = game:GetService("CoreGui")

Index.Name = "Index"
Index.Parent = ScreenGui
Index.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Index.BackgroundTransparency = 1.000
Index.BorderColor3 = Color3.fromRGB(0, 0, 0)
Index.BorderSizePixel = 0
Index.Size = UDim2.new(1, 0, 1, 0)
Index.ZIndex = 0

UIListLayout.Parent = Index
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0, 5)

local function CreateNotifyFrame(Stat, Message)
	-- Gui to Lua
	-- Version: 3.2

	-- Instances:

	local State = Instance.new("Frame")
	local Head = Instance.new("Frame")
	local State_2 = Instance.new("TextLabel")
	local UIGradient = Instance.new("UIGradient")
	local Body = Instance.new("Frame")
	local About = Instance.new("TextLabel")

	--Properties:

	State.Name = "State"
	State.Parent = Index
	State.AnchorPoint = Vector2.new(1, 0.5)
	State.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
	State.BorderColor3 = Color3.fromRGB(0, 0, 0)
	State.BorderSizePixel = 0
	State.Size = UDim2.new(0, 0, 0.099, 0)
	State.ZIndex = 9999

	Head.Name = "Head"
	Head.Parent = State
	Head.AnchorPoint = Vector2.new(1, 0.5)
	Head.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
	Head.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Head.BorderSizePixel = 0
	Head.Position = UDim2.new(1, 0, 0.5, 0)
	Head.Size = UDim2.new(0, 0, 1, 0)
	Head.ZIndex = 10000

	State_2.Name = "State"
	State_2.Parent = Head
	State_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	State_2.BackgroundTransparency = 1.000
	State_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	State_2.BorderSizePixel = 0
	State_2.Position = UDim2.new(0.039316345, 0, 0, 0)
	State_2.Size = UDim2.new(0.960683763, 0, 0.32911393, 0)
	State_2.ZIndex = 10000
	State_2.Font = Enum.Font.SourceSansBold
	State_2.Text = "Notication"
	State_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	State_2.TextScaled = true
	State_2.TextSize = 14.000
	State_2.TextWrapped = true
	State_2.TextXAlignment = Enum.TextXAlignment.Left

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(75, 75, 75)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
	UIGradient.Parent = Head

	Body.Name = "Body"
	Body.Parent = State
	Body.AnchorPoint = Vector2.new(1, 1)
	Body.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
	Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Body.BorderSizePixel = 0
	Body.Position = UDim2.new(1, 0, 1, 0)
	Body.Size = UDim2.new(0, 0, 1, 0)
	Body.ZIndex = 10001

	About.Name = "About"
	About.Parent = Body
	About.Text = Message
	About.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	About.BackgroundTransparency = 1.000
	About.BorderColor3 = Color3.fromRGB(0, 0, 0)
	About.BorderSizePixel = 0
	About.Position = UDim2.new(0.0257611275, 0, 0, 0)
	About.Size = UDim2.new(0.974238873, 0, 1, 0)
	About.ZIndex = 10001
	About.Font = Enum.Font.SourceSans
	About.TextColor3 = Color3.fromRGB(255, 255, 255)
	About.TextTransparency = 1
	About.TextSize = 24.000
	About.TextWrapped = true
	About.TextXAlignment = Enum.TextXAlignment.Left
	About.TextYAlignment = Enum.TextYAlignment.Top

	-- Change:
	if Stat == "Notification" then
		State_2.Text = Stat
		State.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
	elseif Stat == "Error" then
		State_2.Text = Stat
		State.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end

	-- Animate:
	local tweenstate = tweenservice:Create(State, tweeninfo, {Size = UDim2.new(0.250, 0, 0.099)})
	tweenstate:Play()
	
	task.wait(.4)

	local tweenbody = tweenservice:Create(Body, tweeninfo, {Size = UDim2.new(1, 0, 1, 0)})
	tweenbody:Play()
	tweenbody.Completed:Wait()

	Head.Size = UDim2.new(0.893, 0, 1, 0)

	local tweenbody2 = tweenservice:Create(Body, tweeninfo, {Size = UDim2.new(1, 0, 0.671, 0)})
	tweenbody2:Play()
	
	task.wait(.2)
	
	local tweentextt = tweenservice:Create(About, tweeninfo, {TextTransparency = 0})
	tweentextt:Play()
	
	tweenbody2.Completed:Wait()
	task.wait(5)
	local tweenend = tweenservice:Create(Body, tweeninfo, {Size = UDim2.new(1, 0, 1, 0)})
	tweenend:Play()
	local tweentextt2 = tweenservice:Create(About, tweeninfo, {TextTransparency = 1})
	tweentextt2:Play()
	tweenend.Completed:Wait()
	
	Head.Size = UDim2.new(0, 0, 1, 0)
	
	local tweenend2state = tweenservice:Create(State, tweeninfo, {Size = UDim2.new(0, 0, 0.099, 0)})
	local tweenend2body = tweenservice:Create(Body, tweeninfo, {Size = UDim2.new(0, 0, 1, 0)})
	tweenend2body:Play()
	task.wait(.2)
	tweenend2state:Play()
	tweenend2state.Completed:Wait()
	
	State:Destroy()
end

function Module.Notify(Stat, Message)
	spawn(function()
		CreateNotifyFrame(Stat, Message)
	end)
end

return Module

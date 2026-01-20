local Module = {}

Module.Status = {
	Info = {Text = "Info", Color = Color3.fromRGB(0, 170, 255)},
	Success = {Text = "Success", Color = Color3.fromRGB(0, 200, 0)},
	Warning = {Text = "Warning", Color = Color3.fromRGB(255, 170, 0)},
	Error = {Text = "Error", Color = Color3.fromRGB(255, 0, 0)},
	Notification = {Text = "Notification", Color = Color3.fromRGB(170, 0, 255)},
}

-- Variable:

local function rstr(length)
    if not length or length <= 0 then return "" end
	local Random = Random.new() -- ใช้ Random object ของ Roblox
	local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local t = {}
    local n = #charset
    for i = 1, length do
        local idx = Random:NextInteger(1, n)
        t[i] = charset:sub(idx, idx)
    end
    return table.concat(t)
end



local tweenservice = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)

-- Instances:

if not getgenv().notyui then
	ScreenGui = Instance.new("ScreenGui")
	getgenv().notyui = ScreenGui
else
	ScreenGui = getgenv().notyui
end

if not getgenv().notyinx then
	Index = Instance.new("Frame")
	getgenv().notyinx = Index
else
	Index = getgenv().notyinx
end

local UIListLayout = Index:FindFirstChild("UIListLayout") or Instance.new("UIListLayout")

--Properties:

ScreenGui.Name = rstr(20)
ScreenGui.Parent = game:GetService("CoreGui")

Index.Name = rstr(10)
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

-- function build frame:
local function CreateNotifyFrame(Stat, Message, Duration)
	--// Instances
	local State = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")

	local Head = Instance.new("Frame")
	local HeadCorner = Instance.new("UICorner")
	local Accent = Instance.new("Frame")
	local Title = Instance.new("TextLabel")

	local Body = Instance.new("Frame")
	local BodyCorner = Instance.new("UICorner")
	local Msg = Instance.new("TextLabel")

	--// State (Main)
	State.Name = "Notify"
	State.Parent = Index
	State.AnchorPoint = Vector2.new(1, 0.5)
	State.Position = UDim2.new(1, -20, 0.5, 0)
	State.Size = UDim2.new(0, 0, 0.12, 0)
	State.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	State.BackgroundTransparency = 0.05
	State.BorderSizePixel = 0
	State.ZIndex = 50

	UICorner.CornerRadius = UDim.new(0, 14)
	UICorner.Parent = State

	UIStroke.Parent = State
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.Transparency = 0.9
	UIStroke.Thickness = 1

	--// Head
	Head.Parent = State
	Head.Size = UDim2.new(1, 0, 0.35, 0)
	Head.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Head.BorderSizePixel = 0
	Head.ZIndex = 51

	HeadCorner.CornerRadius = UDim.new(0, 14)
	HeadCorner.Parent = Head

	--// Accent bar
	Accent.Parent = Head
	Accent.Size = UDim2.new(0.02, 0, 1, 0)
	Accent.BackgroundColor3 = Stat.Color
	Accent.BorderSizePixel = 0
	Accent.ZIndex = 52

	--// Title
	Title.Parent = Head
	Title.Position = UDim2.new(0.05, 0, 0, 0)
	Title.Size = UDim2.new(0.93, 0, 1, 0)
	Title.BackgroundTransparency = 1
	Title.Text = Stat.Text
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 18
	Title.TextColor3 = Color3.fromRGB(240, 240, 240)
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 53

	--// Body
	Body.Parent = State
	Body.AnchorPoint = Vector2.new(0, 1)
	Body.Position = UDim2.new(0, 0, 1, 0)
	Body.Size = UDim2.new(1, 0, 0, 0)
	Body.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	Body.BackgroundTransparency = 0.05
	Body.BorderSizePixel = 0
	Body.ZIndex = 51

	BodyCorner.CornerRadius = UDim.new(0, 14)
	BodyCorner.Parent = Body

	--// Message
	Msg.Parent = Body
	Msg.Position = UDim2.new(0.05, 0, 0.05, 0)
	Msg.Size = UDim2.new(0.9, 0, 0.9, 0)
	Msg.BackgroundTransparency = 1
	Msg.Text = Message
	Msg.Font = Enum.Font.Gotham
	Msg.TextSize = 15
	Msg.TextWrapped = true
	Msg.TextXAlignment = Enum.TextXAlignment.Left
	Msg.TextYAlignment = Enum.TextYAlignment.Top
	Msg.TextColor3 = Color3.fromRGB(220, 220, 220)
	Msg.TextTransparency = 1
	Msg.ZIndex = 52

	--// Animation
	local tweenOpen = tweenservice:Create(
		State,
		tweeninfo,
		{ Size = UDim2.new(0.28, 0, 0.12, 0) }
	)
	tweenOpen:Play()
	tweenOpen.Completed:Wait()

	local tweenBodyIn = tweenservice:Create(
		Body,
		tweeninfo,
		{ Size = UDim2.new(1, 0, 0.65, 0) }
	)
	tweenBodyIn:Play()
	tweenBodyIn.Completed:Wait()

	tweenservice:Create(
		Msg,
		tweeninfo,
		{ TextTransparency = 0 }
	):Play()

	task.wait(Duration)

	--// Close animation
	tweenservice:Create(
		Msg,
		tweeninfo,
		{ TextTransparency = 1 }
	):Play()

	local tweenBodyOut = tweenservice:Create(
		Body,
		tweeninfo,
		{ Size = UDim2.new(1, 0, 0, 0) }
	)
	tweenBodyOut:Play()
	tweenBodyOut.Completed:Wait()

	local tweenClose = tweenservice:Create(
		State,
		tweeninfo,
		{ Size = UDim2.new(0, 0, 0.12, 0) }
	)
	tweenClose:Play()
	tweenClose.Completed:Wait()

	State:Destroy()
end


function Module.Notify(Stat, Message, dur)
	spawn(function()
		CreateNotifyFrame(Stat, Message, dur)
	end)
end

return Module

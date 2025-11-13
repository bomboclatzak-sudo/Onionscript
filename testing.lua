local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create ScreenGui
local function CreateScreenGui()
	local sg = Instance.new("ScreenGui")
	sg.Name = "OnionScriptUI"
	sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	sg.ResetOnSpawn = false
	return sg
end

function Library:CreateWindow(config)
	config = config or {}
	local title = config.Title or "onionscript"
	local subtitle = config.Subtitle or "Farming"
	
	local screenGui = CreateScreenGui()
	screenGui.Parent = game:GetService("CoreGui")
	
	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 770, 0, 510)
	mainFrame.Position = UDim2.new(0.5, -385, 0.5, -255)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = mainFrame
	
	-- Header
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 50)
	header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	header.BorderSizePixel = 0
	header.Parent = mainFrame
	
	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 6)
	headerCorner.Parent = header
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(0, 200, 1, 0)
	titleLabel.Position = UDim2.new(0, 27, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title .. " " .. subtitle
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = header
	
	-- User Info
	local userLabel = Instance.new("TextLabel")
	userLabel.Name = "UserInfo"
	userLabel.Size = UDim2.new(0, 200, 1, 0)
	userLabel.Position = UDim2.new(1, -220, 0, 0)
	userLabel.BackgroundTransparency = 1
	userLabel.Text = game.Players.LocalPlayer.Name
	userLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	userLabel.TextSize = 14
	userLabel.Font = Enum.Font.Gotham
	userLabel.TextXAlignment = Enum.TextXAlignment.Right
	userLabel.Parent = header
	
	-- Content Container
	local contentFrame = Instance.new("Frame")
	contentFrame.Name = "Content"
	contentFrame.Size = UDim2.new(1, -20, 1, -70)
	contentFrame.Position = UDim2.new(0, 10, 0, 60)
	contentFrame.BackgroundTransparency = 1
	contentFrame.Parent = mainFrame
	
	-- Tab Container
	local tabContainer = Instance.new("Frame")
	tabContainer.Name = "Tabs"
	tabContainer.Size = UDim2.new(1, 0, 1, 0)
	tabContainer.BackgroundTransparency = 1
	tabContainer.Parent = contentFrame
	
	-- Make draggable
	local dragging, dragInput, dragStart, startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	header.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
	local Window = {}
	Window.Tabs = {}
	
	function Window:CreateTab(tabName)
		local Tab = {}
		Tab.Sections = {}
		
		local tabFrame = Instance.new("ScrollingFrame")
		tabFrame.Name = tabName
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.BorderSizePixel = 0
		tabFrame.ScrollBarThickness = 4
		tabFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabFrame.Visible = #Window.Tabs == 0
		tabFrame.Parent = tabContainer
		
		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 10)
		layout.Parent = tabFrame
		
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			tabFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		end)
		
		table.insert(Window.Tabs, {Name = tabName, Frame = tabFrame})
		
		function Tab:CreateSection(sectionName)
			local Section = {}
			Section.Elements = {}
			
			local sectionFrame = Instance.new("Frame")
			sectionFrame.Name = sectionName
			sectionFrame.Size = UDim2.new(0, 240, 0, 50)
			sectionFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			sectionFrame.BorderSizePixel = 0
			sectionFrame.Parent = tabFrame
			
			local sectionCorner = Instance.new("UICorner")
			sectionCorner.CornerRadius = UDim.new(0, 4)
			sectionCorner.Parent = sectionFrame
			
			local sectionTitle = Instance.new("TextLabel")
			sectionTitle.Name = "Title"
			sectionTitle.Size = UDim2.new(1, -20, 0, 30)
			sectionTitle.Position = UDim2.new(0, 10, 0, 10)
			sectionTitle.BackgroundTransparency = 1
			sectionTitle.Text = sectionName
			sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			sectionTitle.TextSize = 16
			sectionTitle.Font = Enum.Font.GothamBold
			sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
			sectionTitle.Parent = sectionFrame
			
			local elementContainer = Instance.new("Frame")
			elementContainer.Name = "Elements"
			elementContainer.Size = UDim2.new(1, -20, 1, -45)
			elementContainer.Position = UDim2.new(0, 10, 0, 40)
			elementContainer.BackgroundTransparency = 1
			elementContainer.Parent = sectionFrame
			
			local elementLayout = Instance.new("UIListLayout")
			elementLayout.SortOrder = Enum.SortOrder.LayoutOrder
			elementLayout.Padding = UDim.new(0, 8)
			elementLayout.Parent = elementContainer
			
			elementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				sectionFrame.Size = UDim2.new(0, 240, 0, elementLayout.AbsoluteContentSize.Y + 55)
			end)
			
			function Section:AddToggle(config)
				config = config or {}
				local name = config.Name or "Toggle"
				local default = config.Default or false
				local callback = config.Callback or function() end
				
				local toggleFrame = Instance.new("Frame")
				toggleFrame.Name = "Toggle"
				toggleFrame.Size = UDim2.new(1, 0, 0, 25)
				toggleFrame.BackgroundTransparency = 1
				toggleFrame.Parent = elementContainer
				
				local toggleLabel = Instance.new("TextLabel")
				toggleLabel.Size = UDim2.new(1, -30, 1, 0)
				toggleLabel.BackgroundTransparency = 1
				toggleLabel.Text = name
				toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				toggleLabel.TextSize = 13
				toggleLabel.Font = Enum.Font.Gotham
				toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
				toggleLabel.Parent = toggleFrame
				
				local toggleButton = Instance.new("TextButton")
				toggleButton.Size = UDim2.new(0, 20, 0, 20)
				toggleButton.Position = UDim2.new(1, -20, 0, 2)
				toggleButton.BackgroundColor3 = default and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 60)
				toggleButton.Text = ""
				toggleButton.AutoButtonColor = false
				toggleButton.Parent = toggleFrame
				
				local buttonCorner = Instance.new("UICorner")
				buttonCorner.CornerRadius = UDim.new(0, 3)
				buttonCorner.Parent = toggleButton
				
				local enabled = default
				
				toggleButton.MouseButton1Click:Connect(function()
					enabled = not enabled
					local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2), {
						BackgroundColor3 = enabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 60)
					})
					tween:Play()
					callback(enabled)
				end)
				
				return {
					SetValue = function(self, value)
						enabled = value
						toggleButton.BackgroundColor3 = enabled and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(60, 60, 60)
						callback(enabled)
					end
				}
			end
			
			function Section:AddDropdown(config)
				config = config or {}
				local name = config.Name or "Dropdown"
				local options = config.Options or {"Option 1", "Option 2"}
				local default = config.Default or options[1]
				local callback = config.Callback or function() end
				
				local dropdownFrame = Instance.new("Frame")
				dropdownFrame.Name = "Dropdown"
				dropdownFrame.Size = UDim2.new(1, 0, 0, 50)
				dropdownFrame.BackgroundTransparency = 1
				dropdownFrame.Parent = elementContainer
				
				local dropdownLabel = Instance.new("TextLabel")
				dropdownLabel.Size = UDim2.new(1, 0, 0, 20)
				dropdownLabel.BackgroundTransparency = 1
				dropdownLabel.Text = name
				dropdownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				dropdownLabel.TextSize = 13
				dropdownLabel.Font = Enum.Font.Gotham
				dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
				dropdownLabel.Parent = dropdownFrame
				
				local dropdownButton = Instance.new("TextButton")
				dropdownButton.Size = UDim2.new(1, 0, 0, 25)
				dropdownButton.Position = UDim2.new(0, 0, 0, 25)
				dropdownButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				dropdownButton.Text = "  " .. default
				dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				dropdownButton.TextSize = 12
				dropdownButton.Font = Enum.Font.Gotham
				dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
				dropdownButton.AutoButtonColor = false
				dropdownButton.Parent = dropdownFrame
				
				local dropdownCorner = Instance.new("UICorner")
				dropdownCorner.CornerRadius = UDim.new(0, 3)
				dropdownCorner.Parent = dropdownButton
				
				local arrow = Instance.new("TextLabel")
				arrow.Size = UDim2.new(0, 20, 1, 0)
				arrow.Position = UDim2.new(1, -20, 0, 0)
				arrow.BackgroundTransparency = 1
				arrow.Text = "▼"
				arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
				arrow.TextSize = 10
				arrow.Font = Enum.Font.Gotham
				arrow.Parent = dropdownButton
				
				local currentValue = default
				
				dropdownButton.MouseButton1Click:Connect(function()
					-- Cycle through options
					local currentIndex = table.find(options, currentValue)
					local nextIndex = (currentIndex % #options) + 1
					currentValue = options[nextIndex]
					dropdownButton.Text = "  " .. currentValue
					callback(currentValue)
				end)
				
				return {
					SetValue = function(self, value)
						if table.find(options, value) then
							currentValue = value
							dropdownButton.Text = "  " .. currentValue
							callback(currentValue)
						end
					end
				}
			end
			
			function Section:AddButton(config)
				config = config or {}
				local name = config.Name or "Button"
				local callback = config.Callback or function() end
				
				local buttonFrame = Instance.new("TextButton")
				buttonFrame.Name = "Button"
				buttonFrame.Size = UDim2.new(1, 0, 0, 30)
				buttonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				buttonFrame.Text = name
				buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
				buttonFrame.TextSize = 13
				buttonFrame.Font = Enum.Font.Gotham
				buttonFrame.AutoButtonColor = false
				buttonFrame.Parent = elementContainer
				
				local buttonCorner = Instance.new("UICorner")
				buttonCorner.CornerRadius = UDim.new(0, 3)
				buttonCorner.Parent = buttonFrame
				
				buttonFrame.MouseButton1Click:Connect(function()
					local tween = TweenService:Create(buttonFrame, TweenInfo.new(0.1), {
						BackgroundColor3 = Color3.fromRGB(45, 45, 45)
					})
					tween:Play()
					tween.Completed:Connect(function()
						TweenService:Create(buttonFrame, TweenInfo.new(0.1), {
							BackgroundColor3 = Color3.fromRGB(35, 35, 35)
						}):Play()
					end)
					callback()
				end)
			end
			
			function Section:AddSlider(config)
				config = config or {}
				local name = config.Name or "Slider"
				local min = config.Min or 0
				local max = config.Max or 100
				local default = config.Default or 50
				local increment = config.Increment or 1
				local callback = config.Callback or function() end
				
				local sliderFrame = Instance.new("Frame")
				sliderFrame.Name = "Slider"
				sliderFrame.Size = UDim2.new(1, 0, 0, 50)
				sliderFrame.BackgroundTransparency = 1
				sliderFrame.Parent = elementContainer
				
				local sliderLabel = Instance.new("TextLabel")
				sliderLabel.Size = UDim2.new(1, -40, 0, 20)
				sliderLabel.BackgroundTransparency = 1
				sliderLabel.Text = name
				sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				sliderLabel.TextSize = 13
				sliderLabel.Font = Enum.Font.Gotham
				sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
				sliderLabel.Parent = sliderFrame
				
				local valueLabel = Instance.new("TextLabel")
				valueLabel.Size = UDim2.new(0, 35, 0, 20)
				valueLabel.Position = UDim2.new(1, -35, 0, 0)
				valueLabel.BackgroundTransparency = 1
				valueLabel.Text = tostring(default)
				valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				valueLabel.TextSize = 12
				valueLabel.Font = Enum.Font.Gotham
				valueLabel.TextXAlignment = Enum.TextXAlignment.Right
				valueLabel.Parent = sliderFrame
				
				local sliderBack = Instance.new("Frame")
				sliderBack.Size = UDim2.new(1, 0, 0, 4)
				sliderBack.Position = UDim2.new(0, 0, 0, 30)
				sliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				sliderBack.BorderSizePixel = 0
				sliderBack.Parent = sliderFrame
				
				local sliderBackCorner = Instance.new("UICorner")
				sliderBackCorner.CornerRadius = UDim.new(0, 2)
				sliderBackCorner.Parent = sliderBack
				
				local sliderFill = Instance.new("Frame")
				sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
				sliderFill.BackgroundColor3 = Color3.fromRGB(255, 230, 100)
				sliderFill.BorderSizePixel = 0
				sliderFill.Parent = sliderBack
				
				local sliderFillCorner = Instance.new("UICorner")
				sliderFillCorner.CornerRadius = UDim.new(0, 2)
				sliderFillCorner.Parent = sliderFill
				
				local currentValue = default
				local dragging = false
				
				local function updateSlider(input)
					local relativeX = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
					local rawValue = min + (relativeX * (max - min))
					currentValue = math.floor(rawValue / increment + 0.5) * increment
					currentValue = math.clamp(currentValue, min, max)
					
					sliderFill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)
					valueLabel.Text = tostring(currentValue)
					callback(currentValue)
				end
				
				sliderBack.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						updateSlider(input)
					end
				end)
				
				sliderBack.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
				
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						updateSlider(input)
					end
				end)
				
				return {
					SetValue = function(self, value)
						currentValue = math.clamp(value, min, max)
						sliderFill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)
						valueLabel.Text = tostring(currentValue)
						callback(currentValue)
					end
				}
			end
			
			table.insert(Tab.Sections, Section)
			return Section
		end
		
		return Tab
	end
	
	return Window
end

return Library

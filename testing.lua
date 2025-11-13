
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
	local username = config.Username or game.Players.LocalPlayer.Name
	
	local screenGui = CreateScreenGui()
	screenGui.Parent = game:GetService("CoreGui")
	
	-- Main Frame
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(0, 770, 0, 510)
	mainFrame.Position = UDim2.new(0.5, -385, 0.5, -255)
	mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	mainFrame.BorderSizePixel = 0
	mainFrame.Parent = screenGui
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = mainFrame
	
	-- Header
	local header = Instance.new("Frame")
	header.Name = "Header"
	header.Size = UDim2.new(1, 0, 0, 60)
	header.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	header.BorderSizePixel = 0
	header.Parent = mainFrame
	
	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 8)
	headerCorner.Parent = header
	
	-- Fix header corners (bottom should be square)
	local headerCoverBottom = Instance.new("Frame")
	headerCoverBottom.Size = UDim2.new(1, 0, 0, 8)
	headerCoverBottom.Position = UDim2.new(0, 0, 1, -8)
	headerCoverBottom.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	headerCoverBottom.BorderSizePixel = 0
	headerCoverBottom.Parent = header
	
	-- Logo/Icon
	local logo = Instance.new("ImageLabel")
	logo.Size = UDim2.new(0, 24, 0, 24)
	logo.Position = UDim2.new(0, 27, 0, 18)
	logo.BackgroundTransparency = 1
	logo.Image = "rbxassetid://7733992901" -- Eye icon placeholder
	logo.ImageColor3 = Color3.fromRGB(255, 255, 255)
	logo.Parent = header
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(0, 200, 0, 24)
	titleLabel.Position = UDim2.new(0, 58, 0, 18)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = header
	
	-- Subtitle
	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Name = "Subtitle"
	subtitleLabel.Size = UDim2.new(0, 200, 0, 24)
	subtitleLabel.Position = UDim2.new(0, 58 + titleLabel.TextBounds.X + 5, 0, 18)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = subtitle
	subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	subtitleLabel.TextSize = 16
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	subtitleLabel.Parent = header
	
	-- User Info
	local userLabel = Instance.new("TextLabel")
	userLabel.Name = "UserInfo"
	userLabel.Size = UDim2.new(0, 200, 0, 20)
	userLabel.Position = UDim2.new(1, -240, 0, 14)
	userLabel.BackgroundTransparency = 1
	userLabel.Text = username
	userLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	userLabel.TextSize = 13
	userLabel.Font = Enum.Font.Gotham
	userLabel.TextXAlignment = Enum.TextXAlignment.Right
	userLabel.Parent = header
	
	-- Expires never
	local expiresLabel = Instance.new("TextLabel")
	expiresLabel.Name = "Expires"
	expiresLabel.Size = UDim2.new(0, 200, 0, 16)
	expiresLabel.Position = UDim2.new(1, -240, 0, 32)
	expiresLabel.BackgroundTransparency = 1
	expiresLabel.Text = "expires: never"
	expiresLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
	expiresLabel.TextSize = 11
	expiresLabel.Font = Enum.Font.Gotham
	expiresLabel.TextXAlignment = Enum.TextXAlignment.Right
	expiresLabel.Parent = header
	
	-- User Icon
	local userIcon = Instance.new("ImageLabel")
	userIcon.Size = UDim2.new(0, 28, 0, 28)
	userIcon.Position = UDim2.new(1, -30, 0, 16)
	userIcon.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
	userIcon.BorderSizePixel = 0
	userIcon.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	userIcon.Parent = header
	
	local userIconCorner = Instance.new("UICorner")
	userIconCorner.CornerRadius = UDim.new(1, 0)
	userIconCorner.Parent = userIcon
	
	-- Content Container (3 column layout)
	local contentFrame = Instance.new("Frame")
	contentFrame.Name = "Content"
	contentFrame.Size = UDim2.new(1, -40, 1, -90)
	contentFrame.Position = UDim2.new(0, 20, 0, 70)
	contentFrame.BackgroundTransparency = 1
	contentFrame.Parent = mainFrame
	
	-- Three columns
	local columns = {}
	for i = 1, 3 do
		local column = Instance.new("ScrollingFrame")
		column.Name = "Column" .. i
		column.Size = UDim2.new(0.33, -7, 1, 0)
		column.Position = UDim2.new((i-1) * 0.33, (i-1) * 10, 0, 0)
		column.BackgroundTransparency = 1
		column.BorderSizePixel = 0
		column.ScrollBarThickness = 4
		column.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
		column.CanvasSize = UDim2.new(0, 0, 0, 0)
		column.Parent = contentFrame
		
		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 10)
		layout.Parent = column
		
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			column.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		end)
		
		columns[i] = column
	end
	
	-- Bottom Icons
	local bottomBar = Instance.new("Frame")
	bottomBar.Name = "BottomBar"
	bottomBar.Size = UDim2.new(1, -40, 0, 30)
	bottomBar.Position = UDim2.new(0, 20, 1, -40)
	bottomBar.BackgroundTransparency = 1
	bottomBar.Parent = mainFrame
	
	local searchIcon = Instance.new("ImageLabel")
	searchIcon.Size = UDim2.new(0, 20, 0, 20)
	searchIcon.Position = UDim2.new(0, 5, 0, 5)
	searchIcon.BackgroundTransparency = 1
	searchIcon.Image = "rbxassetid://7733919610"
	searchIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
	searchIcon.Parent = bottomBar
	
	local saveIcon = Instance.new("ImageLabel")
	saveIcon.Size = UDim2.new(0, 20, 0, 20)
	saveIcon.Position = UDim2.new(0, 35, 0, 5)
	saveIcon.BackgroundTransparency = 1
	saveIcon.Image = "rbxassetid://7733674079"
	saveIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
	saveIcon.Parent = bottomBar
	
	local helpIcon = Instance.new("ImageLabel")
	helpIcon.Size = UDim2.new(0, 20, 0, 20)
	helpIcon.Position = UDim2.new(1, -25, 0, 5)
	helpIcon.BackgroundTransparency = 1
	helpIcon.Image = "rbxassetid://7733919610"
	helpIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
	helpIcon.Parent = bottomBar
	
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
	Window.Columns = columns
	
	function Window:CreateSection(config)
		config = config or {}
		local name = config.Name or "Section"
		local column = config.Column or 1
		
		local Section = {}
		Section.Elements = {}
		
		local sectionFrame = Instance.new("Frame")
		sectionFrame.Name = name
		sectionFrame.Size = UDim2.new(1, 0, 0, 50)
		sectionFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		sectionFrame.BorderSizePixel = 0
		sectionFrame.Parent = columns[column]
		
		local sectionCorner = Instance.new("UICorner")
		sectionCorner.CornerRadius = UDim.new(0, 6)
		sectionCorner.Parent = sectionFrame
		
		local sectionTitle = Instance.new("TextLabel")
		sectionTitle.Name = "Title"
		sectionTitle.Size = UDim2.new(1, -24, 0, 25)
		sectionTitle.Position = UDim2.new(0, 12, 0, 8)
		sectionTitle.BackgroundTransparency = 1
		sectionTitle.Text = name
		sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		sectionTitle.TextSize = 14
		sectionTitle.Font = Enum.Font.GothamBold
		sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
		sectionTitle.Parent = sectionFrame
		
		local elementContainer = Instance.new("Frame")
		elementContainer.Name = "Elements"
		elementContainer.Size = UDim2.new(1, -24, 1, -40)
		elementContainer.Position = UDim2.new(0, 12, 0, 35)
		elementContainer.BackgroundTransparency = 1
		elementContainer.Parent = sectionFrame
		
		local elementLayout = Instance.new("UIListLayout")
		elementLayout.SortOrder = Enum.SortOrder.LayoutOrder
		elementLayout.Padding = UDim.new(0, 6)
		elementLayout.Parent = elementContainer
		
		elementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			sectionFrame.Size = UDim2.new(1, 0, 0, elementLayout.AbsoluteContentSize.Y + 50)
		end)
		
		function Section:AddToggle(config)
			config = config or {}
			local name = config.Name or "Toggle"
			local default = config.Default or false
			local callback = config.Callback or function() end
			
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Name = "Toggle"
			toggleFrame.Size = UDim2.new(1, 0, 0, 18)
			toggleFrame.BackgroundTransparency = 1
			toggleFrame.Parent = elementContainer
			
			local toggleLabel = Instance.new("TextLabel")
			toggleLabel.Size = UDim2.new(1, 0, 1, 0)
			toggleLabel.BackgroundTransparency = 1
			toggleLabel.Text = name
			toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			toggleLabel.TextSize = 12
			toggleLabel.Font = Enum.Font.Gotham
			toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			toggleLabel.Parent = toggleFrame
			
			local enabled = default
			callback(enabled)
			
			return {
				SetValue = function(self, value)
					enabled = value
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
			dropdownFrame.Size = UDim2.new(1, 0, 0, 42)
			dropdownFrame.BackgroundTransparency = 1
			dropdownFrame.Parent = elementContainer
			
			local dropdownLabel = Instance.new("TextLabel")
			dropdownLabel.Size = UDim2.new(1, 0, 0, 18)
			dropdownLabel.BackgroundTransparency = 1
			dropdownLabel.Text = name
			dropdownLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			dropdownLabel.TextSize = 12
			dropdownLabel.Font = Enum.Font.Gotham
			dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
			dropdownLabel.Parent = dropdownFrame
			
			local dropdownButton = Instance.new("TextButton")
			dropdownButton.Size = UDim2.new(1, 0, 0, 22)
			dropdownButton.Position = UDim2.new(0, 0, 0, 20)
			dropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			dropdownButton.Text = "  " .. default
			dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			dropdownButton.TextSize = 11
			dropdownButton.Font = Enum.Font.Gotham
			dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
			dropdownButton.AutoButtonColor = false
			dropdownButton.Parent = dropdownFrame
			
			local dropdownCorner = Instance.new("UICorner")
			dropdownCorner.CornerRadius = UDim.new(0, 4)
			dropdownCorner.Parent = dropdownButton
			
			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 20, 1, 0)
			arrow.Position = UDim2.new(1, -20, 0, 0)
			arrow.BackgroundTransparency = 1
			arrow.Text = "▼"
			arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
			arrow.TextSize = 8
			arrow.Font = Enum.Font.Gotham
			arrow.Parent = dropdownButton
			
			local currentValue = default
			
			dropdownButton.MouseButton1Click:Connect(function()
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
			buttonFrame.Size = UDim2.new(1, 0, 0, 26)
			buttonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			buttonFrame.Text = name
			buttonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
			buttonFrame.TextSize = 11
			buttonFrame.Font = Enum.Font.Gotham
			buttonFrame.AutoButtonColor = false
			buttonFrame.Parent = elementContainer
			
			local buttonCorner = Instance.new("UICorner")
			buttonCorner.CornerRadius = UDim.new(0, 4)
			buttonCorner.Parent = buttonFrame
			
			buttonFrame.MouseButton1Click:Connect(function()
				local tween = TweenService:Create(buttonFrame, TweenInfo.new(0.1), {
					BackgroundColor3 = Color3.fromRGB(55, 55, 55)
				})
				tween:Play()
				tween.Completed:Connect(function()
					TweenService:Create(buttonFrame, TweenInfo.new(0.1), {
						BackgroundColor3 = Color3.fromRGB(45, 45, 45)
					}):Play()
				end)
				callback()
			end)
		end
		
		function Section:AddLabel(text)
			local labelFrame = Instance.new("TextLabel")
			labelFrame.Name = "Label"
			labelFrame.Size = UDim2.new(1, 0, 0, 18)
			labelFrame.BackgroundTransparency = 1
			labelFrame.Text = text
			labelFrame.TextColor3 = Color3.fromRGB(180, 180, 180)
			labelFrame.TextSize = 11
			labelFrame.Font = Enum.Font.Gotham
			labelFrame.TextXAlignment = Enum.TextXAlignment.Left
			labelFrame.TextWrapped = true
			labelFrame.Parent = elementContainer
		end
		
		function Section:AddColorPicker(config)
			config = config or {}
			local name = config.Name or "Color"
			local default = config.Default or Color3.fromRGB(255, 255, 255)
			local callback = config.Callback or function() end
			
			local colorFrame = Instance.new("Frame")
			colorFrame.Name = "ColorPicker"
			colorFrame.Size = UDim2.new(1, 0, 0, 20)
			colorFrame.BackgroundTransparency = 1
			colorFrame.Parent = elementContainer
			
			local colorLabel = Instance.new("TextLabel")
			colorLabel.Size = UDim2.new(1, -30, 1, 0)
			colorLabel.BackgroundTransparency = 1
			colorLabel.Text = name
			colorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			colorLabel.TextSize = 12
			colorLabel.Font = Enum.Font.Gotham
			colorLabel.TextXAlignment = Enum.TextXAlignment.Left
			colorLabel.Parent = colorFrame
			
			local colorDisplay = Instance.new("Frame")
			colorDisplay.Size = UDim2.new(0, 50, 0, 16)
			colorDisplay.Position = UDim2.new(1, -50, 0, 2)
			colorDisplay.BackgroundColor3 = default
			colorDisplay.BorderSizePixel = 0
			colorDisplay.Parent = colorFrame
			
			local colorCorner = Instance.new("UICorner")
			colorCorner.CornerRadius = UDim.new(0, 3)
			colorCorner.Parent = colorDisplay
		end
		
		function Section:AddSlider(config)
			config = config or {}
			local name = config.Name or "Slider"
			local min = config.Min or 0
			local max = config.Max or 100
			local default = config.Default or 50
			local callback = config.Callback or function() end
			
			local sliderFrame = Instance.new("Frame")
			sliderFrame.Name = "Slider"
			sliderFrame.Size = UDim2.new(1, 0, 0, 40)
			sliderFrame.BackgroundTransparency = 1
			sliderFrame.Parent = elementContainer
			
			local sliderLabel = Instance.new("TextLabel")
			sliderLabel.Size = UDim2.new(1, -30, 0, 18)
			sliderLabel.BackgroundTransparency = 1
			sliderLabel.Text = name
			sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			sliderLabel.TextSize = 12
			sliderLabel.Font = Enum.Font.Gotham
			sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			sliderLabel.Parent = sliderFrame
			
			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0, 25, 0, 18)
			valueLabel.Position = UDim2.new(1, -25, 0, 0)
			valueLabel.BackgroundTransparency = 1
			valueLabel.Text = tostring(default)
			valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			valueLabel.TextSize = 11
			valueLabel.Font = Enum.Font.Gotham
			valueLabel.TextXAlignment = Enum.TextXAlignment.Right
			valueLabel.Parent = sliderFrame
			
			local sliderBack = Instance.new("Frame")
			sliderBack.Size = UDim2.new(1, 0, 0, 6)
			sliderBack.Position = UDim2.new(0, 0, 0, 24)
			sliderBack.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			sliderBack.BorderSizePixel = 0
			sliderBack.Parent = sliderFrame
			
			local sliderBackCorner = Instance.new("UICorner")
			sliderBackCorner.CornerRadius = UDim.new(0, 3)
			sliderBackCorner.Parent = sliderBack
			
			local sliderFill = Instance.new("Frame")
			sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			sliderFill.BackgroundColor3 = Color3.fromRGB(255, 220, 80)
			sliderFill.BorderSizePixel = 0
			sliderFill.Parent = sliderBack
			
			local sliderFillCorner = Instance.new("UICorner")
			sliderFillCorner.CornerRadius = UDim.new(0, 3)
			sliderFillCorner.Parent = sliderFill
			
			local currentValue = default
			local dragging = false
			
			local function updateSlider(input)
				local relativeX = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
				currentValue = math.floor(min + (relativeX * (max - min)))
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
		
		function Section:AddDropdownWithLabel(config)
			config = config or {}
			local name = config.Name or "Dropdown"
			local options = config.Options or {"Option 1"}
			local default = config.Default or options[1]
			local callback = config.Callback or function() end
			
			-- Add label first
			self:AddLabel(name)
			
			-- Then dropdown
			local dropdownButton = Instance.new("TextButton")
			dropdownButton.Size = UDim2.new(1, 0, 0, 22)
			dropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			dropdownButton.Text = "  " .. default
			dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			dropdownButton.TextSize = 11
			dropdownButton.Font = Enum.Font.Gotham
			dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
			dropdownButton.AutoButtonColor = false
			dropdownButton.Parent = elementContainer
			
			local dropdownCorner = Instance.new("UICorner")
			dropdownCorner.CornerRadius = UDim.new(0, 4)
			dropdownCorner.Parent = dropdownButton
			
			local arrow = Instance.new("TextLabel")
			arrow.Size = UDim2.new(0, 20, 1, 0)
			arrow.Position = UDim2.new(1, -20, 0, 0)
			arrow.BackgroundTransparency = 1
			arrow.Text = "▼"
			arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
			arrow.TextSize = 8
			arrow.Font = Enum.Font.Gotham
			arrow.Parent = dropdownButton
			
			local currentValue = default
			
			dropdownButton.MouseButton1Click:Connect(function()
				local currentIndex = table.find(options, currentValue)
				local nextIndex = (currentIndex % #options) + 1
				currentValue = options[nextIndex]
				dropdownButton.Text = "  " .. currentValue
				callback(currentValue)
			end)
		end
		
		return Section
	end
	
	return Window
end

return Library

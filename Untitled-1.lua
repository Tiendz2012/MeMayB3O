local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local target = nil

-- Tìm quái vật có tên là "Soldier"
local function findTarget()
    for _, object in pairs(game.Workspace:GetChildren()) do
        -- Kiểm tra xem đối tượng có tên là "Soldier" và có "HumanoidRootPart" hay không
        if object:IsA("Model") and object.Name == "Soldier" and object:FindFirstChild("HumanoidRootPart") then
            target = object  -- Lưu quái vật "Soldier"
            break
        end
    end
end

-- Tạo Tween để bay đến quái vật "Soldier"
local function createTween(targetPosition)
    local tweenInfo = TweenInfo.new(
        2,  -- Thời gian di chuyển (2 giây)
        Enum.EasingStyle.Linear,  -- Kiểu chuyển động mượt mà
        Enum.EasingDirection.Out,  -- Chuyển động dừng dần
        1,  -- Chỉ lặp lại 1 lần
        false,  -- Không lặp lại ngược lại
        0  -- Không delay
    )
    
    -- Tạo tween di chuyển đến vị trí mục tiêu
    local goal = {Position = targetPosition + Vector3.new(0, 10, 0)}  -- Bay lên cao một chút
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, goal)
    return tween
end

-- Di chuyển đến quái vật "Soldier"
local function flyToTarget()
    while true do
        findTarget()  -- Tìm quái vật "Soldier"
        if target and target:FindFirstChild("HumanoidRootPart") then
            local targetPosition = target.HumanoidRootPart.Position
            -- Tạo và chạy tween để bay đến quái vật "Soldier"
            local tween = createTween(targetPosition)
            tween:Play()
            tween.Completed:Wait()  -- Chờ tween hoàn tất
        end
        wait(1)  -- Đợi 1 giây trước khi tìm lại quái vật (nếu có thay đổi)
    end
end

-- Bắt đầu bay đến quái vật "Soldier"
flyToTarget()
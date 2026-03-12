-- ONE SCRIPT FIX LAG SYSTEM

local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain
local RunService = game:GetService("RunService")

-------------------------------------------------
-- FPS BOOST (LIGHTING)
-------------------------------------------------

Lighting.GlobalShadows = false
Lighting.FogEnd = 100000

for _,v in pairs(Lighting:GetChildren()) do
	if v:IsA("BloomEffect")
	or v:IsA("SunRaysEffect")
	or v:IsA("DepthOfFieldEffect")
	or v:IsA("ColorCorrectionEffect") then
		
		v.Enabled = false
		
	end
end

-------------------------------------------------
-- MAP / BUILDING OPTIMIZER
-------------------------------------------------

for _,v in pairs(workspace:GetDescendants()) do
	
	if v:IsA("BasePart") then
		
		v.CastShadow = false
		v.Material = Enum.Material.Plastic
		
	end
	
end

-------------------------------------------------
-- SKILL EFFECT OPTIMIZER
-------------------------------------------------

local function optimizeEffect(v)

	if v:IsA("ParticleEmitter") then
		v.Rate = math.max(1, v.Rate * 0.3)
	end
	
	if v:IsA("Trail") then
		v.Lifetime = 0.1
	end
	
	if v:IsA("Smoke") then
		v.Enabled = false
	end
	
	if v:IsA("Fire") then
		v.Enabled = false
	end
	
	if v:IsA("Explosion") then
		v.BlastPressure = 0
	end
	
end

for _,v in pairs(workspace:GetDescendants()) do
	optimizeEffect(v)
end

workspace.DescendantAdded:Connect(function(v)
	optimizeEffect(v)
end)

-------------------------------------------------
-- WATER OPTIMIZER
-------------------------------------------------

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

-------------------------------------------------
-- AUTO FPS MODE
-------------------------------------------------

RunService.RenderStepped:Connect(function()

	if workspace:GetRealPhysicsFPS() < 50 then
		
		for _,v in pairs(workspace:GetDescendants()) do
			
			if v:IsA("ParticleEmitter") then
				v.Rate = 0
			end
			
			if v:IsA("Trail") then
				v.Enabled = false
			end
			
		end
		
	end
	
end)

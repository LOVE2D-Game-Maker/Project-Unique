------------------------------------------------------------------------------
------------------------Project Unique's GUI framework------------------------
-------------------------Based off of C#'s "Winforms"-------------------------
------------------------------------------------------------------------------

Button = Object:clone()

function Button:init()
	--
end

function Button:Draw()
	DrawText("ttesst")
	love.graphics.point(0,0) --TODO: GetMousePos test
end

function Button:Mousepressed(x,y,btn)
	if button == "l" then
		--
	end
end

toolStrip = Object:clone()

function toolStrip:Draw()
	DrawText("test")
end
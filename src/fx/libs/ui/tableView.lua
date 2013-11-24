-- =============================================================
-- Copyright The Doppler FX. 2012-2013 
-- =============================================================
-- Table View
-- =============================================================
-- Short and Sweet License: 
-- 1. You may use anything you find in the CoronaFX library and sampler to make apps and games for free or $$.
-- 2. You may not sell or distribute CoronaFX or the sampler as your own work.
-- 3. If you intend to use the art or external code assets, you must read and follow the licenses found in the
--    various associated readMe.txt files near those assets.
--
-- Credit?:  Mentioning CoronaFX library and/or The Doppler FX. in your credits is not required, but it would be nice.  Thanks!
--
-- =============================================================
-- Docs: https://thedopplerfx.com/dev/CoronaFX/wiki
-- =============================================================

if( not _G.fx.ui.tableView ) then
	_G.fx.ui.tableView = {}
end
local fxTableView = _G.fx.ui.tableView

local widget = require("widget")

-- ==
--    fx.ui.tableView:new(params) - Core builder function for creating title bars
-- ==
function fxTableView:new(params)
	table.merge(table.merge(fx.theme.tableView, params.class), params)
	local tableView = widget.newTableView(params)

	tableView._insertRow = tableView.insertRow

	function tableView:insertRow(row)
		if row.isCategory then
			table.merge(fx.theme.tableViewRow.category, row)
		else
			if row.isSelected then
				table.merge(fx.theme.tableViewRow.selected, row)
			else
				table.merge(fx.theme.tableViewRow.normal, row)
			end
		end
		tableView:_insertRow(row)
	end

	tableView.id = "fxTableView" .. math.random(0, w)
	tableView.x = fnn(params.x, tableView.width/2)
	tableView.y = fnn(params.y, tableView.height/2)
	if(params.view) then params.view:insert(tableView) end

	

	return tableView
end
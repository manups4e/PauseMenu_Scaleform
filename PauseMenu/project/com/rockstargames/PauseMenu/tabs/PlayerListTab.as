class com.rockstargames.PauseMenu.tabs.PlayerListTab extends com.rockstargames.PauseMenu.tabs.BaseTab
{
	var _title;
	var _selected = 0;
	var _selectedItem;
	var leftX = 0;
	var centerX = 290;
	var rightX = 580;
	var settingsColumn;
	var playersColumn;
	var missionDetails;
	var _focusLevel = 0;
	var orderedColumns = [];
	var _idx;
	var _min;
	var _max;
	var CONTENT;
	function PlayerListTab(mc, val)
	{
		super(mc,val);
		this.CONTENT = mc;
		this.playersColumn = new com.rockstargames.PauseMenu.tabs.playerList.PlayerList(this, this.leftX, 0);
		this.settingsColumn = new com.rockstargames.PauseMenu.tabs.playerList.SettingsList(this, this.centerX, 1);
		//this.missionDetails = new com.rockstargames.PauseMenu.tabs.playerList.MissionPanel(this, this.rightX, "", "", "");
		this.orderedColumns = new Array({id:0, type:"players", column:this.playersColumn}, {id:1, type:"settings", column:this.settingsColumn});
		/*
		{id:1, type:"panel", column:this.missionDetails},
		*/
	}

	function SetPanelsOrder(left, center, right)
	{
		if (left != center && left != right && center != right)
		{
			this.orderedColumns[0].id = left;
			this.orderedColumns[1].id = center;
			this.orderedColumns[2].id = right;
			for (var it in this.orderedColumns)
			{
				switch (this.orderedColumns[it].id)
				{
					case 0 :
						this.orderedColumns[it].column.OFFSET = this.leftX;
						this.orderedColumns[it].column._id = 0;
						break;
					case 1 :
						this.orderedColumns[it].column.OFFSET = this.centerX;
						this.orderedColumns[it].column._id = 1;
						break;
					case 2 :
						this.orderedColumns[it].column.OFFSET = this.rightX;
						this.orderedColumns[it].column._id = 2;
						break;
				}
				this.orderedColumns[it].column.updateItemsDrawing();
			}
		}
	}
	function AddSettings(id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.settingsColumn.AddItem(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function AddPlayer(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.playersColumn.AddItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function RemovePlayer(id)
	{
		this.playersColumn.RemoveItem(id);
	}

	function GoUp(val)
	{
		var ret = -1;
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players")
		{
			ret = this.currentColumn.column.GoUp(val);
		}
		_idx = this.currentColumn.column.currentSelection;
		_min = this.currentColumn.column._minItem;
		_max = this.currentColumn.column._maxItem;
		return ret;
	}

	function GoDown(val)
	{
		var ret = -1;
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players")
		{
			ret = this.currentColumn.column.GoDown(val);
		}
		_idx = this.currentColumn.column.currentSelection;
		_min = this.currentColumn.column._minItem;
		_max = this.currentColumn.column._maxItem;
		return ret;
	}

	function GoLeft(val)
	{
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players")
		{
			_idx = this.currentColumn.column.currentSelection;
			_min = this.currentColumn.column._minItem;
			_max = this.currentColumn.column._maxItem;
			return this.currentColumn.column.GoLeft(val);
		}
	}

	function GoRight(val)
	{
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players")
		{
			_idx = this.currentColumn.column.currentSelection;
			_min = this.currentColumn.column._minItem;
			_max = this.currentColumn.column._maxItem;
			return this.currentColumn.column.GoRight(val);
		}
	}

	function set Focus(f)
	{
		this._focusLevel = f;
		if (this._focusLevel < 0)
		{
			this._focusLevel = 1;
		}
		if (this._focusLevel > 1)
		{
			this._focusLevel = 0;
		}
		switch (this.currentColumn.type)
		{
			case "settings" :
				this.currentColumn.column.currentSelection = 0;
				break;
			case "players" :
				for (var i in this.settingsColumn.ItemList)
				{
					this.settingsColumn.ItemList[i].highlighted = false;
				}
		}
		this.currentColumn.column.updateItemsDrawing();
	}

	function get Focus()
	{
		return this._focusLevel;
	}

	function get currentColumn()
	{
		var curr = "";
		for (var i in this.orderedColumns)
		{
			if (this._focusLevel == this.orderedColumns[i].id)
			{
				curr = this.orderedColumns[i];
				break;
			}
		}
		return curr;
	}

	function GetColumnByType(strName)
	{
		for (var i in this.orderedColumns)
		{
			if (strName == this.orderedColumns[i].type)
			{
				return this.orderedColumns[i];
			}
		}
	}

	function set isVisible(_v)
	{
		super.isVisible = _v;
		this.settingsColumn.IsVisible = _v;
		this.playersColumn.IsVisible = _v;
		if (_v)
		{
			this.settingsColumn.updateItemsDrawing();
			this.playersColumn.updateItemsDrawing();
		}
	}

	function set focused(_f)
	{
		super.focused = _f;
		this.settingsColumn.BodyMask._alpha = _f ? 100 : 60;
		this.settingsColumn.Footer._alpha = _f ? 100 : 60;
		this.settingsColumn.DescriptionSprite._alpha = _f ? 100 : 60;
		this.playersColumn.BodyMask._alpha = _f ? 100 : 60;
		for (var i in this.playersColumn.ItemList)
		{
			if (this.playersColumn.ItemList[i].panel)
			{
				if (this.playersColumn.ItemList[i].panel.Visible)
				{
					this.playersColumn.ItemList[i].panel.itemMC._alpha = _f ? 100 : 60;
				}
			}
		}
		/*
		this.rightItemUpMC._alpha = _f ? 100 : 60;
		this._title.itemMC._alpha = _f ? 100 : 60;
		for (var it in this.ItemList)
		{
		this.ItemList[it]._alpha = _f ? 100 : 60;
		}
		*/
	}

	function Clear()
	{
		this.settingsColumn.Clear();
		this.playersColumn.Clear();
	}

}
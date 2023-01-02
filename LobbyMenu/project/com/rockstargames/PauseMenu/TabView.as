class com.rockstargames.PauseMenu.TabView
{
	var CONTENT;
	var _focusLevel = 0;
	var _title;
	var _selected = 0;
	var _selectedItem;
	var centerItemCount;
	var DescriptionSprite;
	var EnableAnim;
	var AnimType;
	var RightItemList;
	var leftX = 0;
	var centerX = 290;
	var rightX = 580;
	var settingsColumn;
	var playersColumn;
	var missionDetails;
	var orderedColumns = [];
	var _idx;
	var _min;
	var _max;

	function TabView(mc, left, center, right)
	{
		this.CONTENT = mc;
		this.settingsColumn = new com.rockstargames.PauseMenu.lobby.SettingsList(this, this.leftX, 0);
		this.playersColumn = new com.rockstargames.PauseMenu.lobby.PlayerList(this, this.centerX, 1);
		this.missionDetails = new com.rockstargames.PauseMenu.lobby.MissionPanel(this, this.rightX, "", "", "");
		this.orderedColumns = new Array({id:0, type:"settings", column:this.settingsColumn}, {id:1, type:"players", column:this.playersColumn}, {id:2, type:"panel", column:this.missionDetails});
		this.SetPanelsOrder(left,center,right);
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

	function AddSetting(id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.settingsColumn.AddItem(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function AddPlayerItem(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.playersColumn.AddItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function AddMissionPanelItem(id, textLeft, textRight, param3, param4, param5, param6)
	{
		this.missionDetails.AddItem(id,textLeft,textRight,param3,param4,param5,param6);
	}

	function SetPanelPicture(txd, txn)
	{
		this.missionDetails.setPicture(txd,txn);
	}

	function SetMissionPanelTitle(title)
	{
		this.missionDetails.setTitle(title);
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

	function fadeOutLobby()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:0, onComplete:com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf, onCompleteScope:this, onCompleteArgs:[this.CONTENT], ease:17});
	}
	function fadeInLobby()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, onComplete:com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf, onCompleteScope:this, onCompleteArgs:[this.CONTENT], ease:16});
	}

	function set Focus(f)
	{
		this._focusLevel = f;
		if (this._focusLevel < 0)
		{
			this._focusLevel = 2;
		}
		if (this._focusLevel > 2)
		{
			this._focusLevel = 0;
		}
		switch (this.currentColumn.type)
		{
			case "settings" :
				_idx = this.playersColumn.currentSelection;
				_min = this.playersColumn._minItem;
				_max = this.playersColumn._maxItem;
				for (var i in this.playersColumn.ItemList)
				{
					this.playersColumn.ItemList[i].highlighted = false;
				}
				this.playersColumn.updateItemsDrawing();
				break;
			case "players" :
				_idx = this.settingsColumn.currentSelection;
				_min = this.settingsColumn._minItem;
				_max = this.settingsColumn._maxItem;
				for (var i in this.settingsColumn.ItemList)
				{
					this.settingsColumn.ItemList[i].highlighted = false;
				}
				this.settingsColumn.updateItemsDrawing();
				break;
		}
		if (_idx < this.currentColumn.column.itemCount)
		{
			var diff = _idx - _min;
			var res = this.currentColumn.column._minItem + diff;
			this.currentColumn.column.currentSelection = res;
		}
		else
		{
			this.currentColumn.column.currentSelection = this.currentColumn.column._maxItem;
		}
		this.currentColumn.column.updateItemsDrawing();
	}

	function get Focus()
	{
		return this._focusLevel;
	}

	function set isVisible(_v)
	{
		super.isVisible = _v;
		/*
		if (this.LeftItemList.length > 0)
		{
		for (var it in this.LeftItemList)
		{
		this.LeftItemList[it].isVisible = _v;
		}
		}
		*/
	}

	function set focused(_f)
	{
		super.focused = _f;
		/*
		if (this.LeftItemList.length > 0)
		{
		for (var it in this.LeftItemList)
		{
		this.LeftItemList[it].focused = _f;
		}
		}
		*/
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
}
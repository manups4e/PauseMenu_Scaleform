class com.rockstargames.PauseMenu.tabs.TabLeftItem
{
	var _selected;
	var leftItem;
	var rightMenuUp;
	var rightMenuDown;
	var _isvisible;
	var _title;
	var ItemList;
	var _selectedItem;
	var _selectedIndex = 0;
	var _MC;
	var scrollableContent;
	var viewHeight = 0;
	var viewMaskHeight = 430;
	var itemType;
	var rightBodyHovered = false;
	var SCROLL_DURATION = 0.2;
	var SCROLL_DY = 27;
	var footerMC;

	function TabLeftItem(mc, leftLabel, type, param1, param2, param3, param4)
	{
		this._MC = mc;
		this.ItemList = new Array();
		this.leftItem = new com.rockstargames.NativeUI.items.UIMenuItem(leftLabel, "", this._MC, param1, param2, param3, param4);

		// RIMUOVERE CON CODICE SCRIPT E SCALE
		this.leftItem._textColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;
		this.leftItem._textHighlightColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK;
		// RIMUOVERE CON CODICE SCRIPT E SCALE

		this.leftItem.highlighted = false;
		this.itemType = type;
		switch (type)
		{
			case 0 :
				this.rightMenuUp = this._MC.createEmptyMovieClip("empty", this._MC.getNextHighestDepth() + 1000);
				break;
			case 1 :
			case 2 :
			case 3 :
				this.rightMenuUp = this._MC.attachMovie("pauseMenuRightBody", "right_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightMenuUp.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
				this.scrollableContent = this.rightMenuUp.createEmptyMovieClip("viewContainer", this.rightMenuUp.getNextHighestDepth());
				this.rightMenuUp.setMask(this.rightMenuUp.maskMC);
				this.rightMenuUp._x = 290;
				this.rightMenuUp.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverRB);
				this.rightMenuUp.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutRB);
				this.rightBodyHovered = false;
				this.rightMenuUp._visible = false;
				break;
		}
		this.footerMC = this._MC.attachMovie("footer", "footer_mc_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.footerMC._visible = false;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.footerMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.footerMC._x = 290;
		this.footerMC._y = 432;
	}

	function AddTitle(txt)
	{
		if (this.itemType != 0 && this.itemType != 2 && this.itemType != 3)
		{
			if (this._title == undefined)
			{
				this._title = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent);
				var size = 50;
				this._title.itemMC.labelMC.titleTF.autoSize = "left";
				this._title.itemMC.labelMC.titleTF.multiline = false;
				this._title.itemMC.labelMC.titleTF.htmlText = "<font face=\'$Font2\' size=\'" + size + "\'>" + txt + "</font>";
				this._title.itemMC._y = 5;
				this._title.snapBGGrid(this._title.bgMC);
			}
		}
	}

	function AddItem(_type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		if (this.itemType != 0)
		{
			var item;
			switch (_type)
			{
				case 0 :
					item = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
				case 1 :
					item = new com.rockstargames.PauseMenu.items.StatsTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
				case 2 :
					item = new com.rockstargames.PauseMenu.items.SettingsTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
			}
			this.ItemList.push(item);
			this.updateItemsHeight();
			this.scrollToBottom();
		}
	}

	function updateItemsHeight()
	{
		var _th = (this._title == undefined) ? (this.itemType == 2 || this.itemType == 3) ? 0 : 5 : this._title.itemMC._y + this._title.itemMC.bgMC._height;
		for (var it in this.ItemList)
		{
			var oldItemY = it > 0 ? this.ItemList[it - 1].itemMC._y : 0;
			var oldItemH = it > 0 ? this.ItemList[it - 1].itemMC._height : 0;
			if (it == 0)
			{
				this.ItemList[it].itemMC._y = _th + 2;
			}
			else
			{
				this.ItemList[it].itemMC._y = oldItemH + oldItemY;
			}
		}
		this.viewHeight = this.ItemList[this.ItemList.length - 1].itemMC._y + this.ItemList[this.ItemList.length - 1].itemMC.bgMC._height;
		if (this.itemType != 0 || this.itemType != 1)
		{
			this.rightMenuUp.bgMC._height = (this.viewHeight < this.viewMaskHeight) ? this.viewHeight : this.viewMaskHeight;
		}
	}

	function scrollToBottom()
	{
		if (this.viewHeight > this.viewMaskHeight)
		{
			this.scrollableContent._y = -(this.viewHeight - this.viewMaskHeight);
		}
	}

	function mOverRB()
	{
		this.rightBodyHovered = true;
	}
	function mOutRB()
	{
		this.rightBodyHovered = false;
	}

	function set isVisible(_v)
	{
		this._isvisible = _v;
		this.leftItem.isVisible = _v;
		if (this.itemType != 0)
		{
			this.rightMenuUp._visible = _v;
			this._title.itemMC._visible = _v;
			for (var it in this.ItemList)
			{
				this.ItemList[it].isVisible = _v;
			}
		}
		this.updateItemsHeight();
	}

	function get isVisible()
	{
		return this._isvisible;
	}

	function set Selected(_v)
	{
		this._selected = _v;
		this.leftItem.highlighted = _v;
		if (this.itemType != 0)
		{
			this.rightMenuUp._visible = _v;
			this._title.itemMC._visible = _v;
			for (var it in this.ItemList)
			{
				this.ItemList[it].isVisible = _v;
			}
			this.footerMC._visible = (_v && (this.viewHeight > this.viewMaskHeight));
		}
	}
	function get Selected()
	{
		return this._selected;
	}

	function set focused(_f)
	{
		this.leftItem.itemMC._alpha = _f ? 100 : 60;
		if (this.itemType != 0)
		{
			this.rightMenuUp._alpha = _f ? 100 : 60;
			this._title.itemMC._alpha = _f ? 100 : 60;
			for (var it in this.ItemList)
			{
				this.ItemList[it]._alpha = _f ? 100 : 60;
			}
		}
	}

	function get panelHovered():Boolean
	{
		return this.rightBodyHovered;
	}

	function set highlighted(_h)
	{
		this.leftItem.highlighted = _h;
	}

	function get highlighted()
	{
		return this.leftItem.highlighted;
	}

	function scrollAll(targetIndex, tween)
	{
		if (tween == undefined)
		{
			tween = true;
		}

		if (this.viewHeight > this.viewMaskHeight)
		{
			var _loc2_ = this.scrollableContent._y;
			switch (targetIndex)
			{
				case 1 :
					_loc2_ = this.scrollableContent._y - 27;
					if (_loc2_ <= -(this.viewHeight - this.viewMaskHeight))
					{
						_loc2_ = -(this.viewHeight - this.viewMaskHeight);
					}
					break;
				case -1 :
					_loc2_ = this.scrollableContent._y + 27;
					if (_loc2_ >= 0)
					{
						_loc2_ = 0;
					}
					break;
			}
			if (tween)
			{
				com.rockstargames.ui.tweenStar.TweenStarLite.to(this.scrollableContent,this.SCROLL_DURATION,{_y:_loc2_, ease:com.rockstargames.ui.tweenStar.Ease.LINEAR});
			}
			else
			{
				this.scrollableContent._y = _loc2_;
			}
		}
	}

	function updateItemList()
	{

		for (var it in this.ItemList)
		{
			this.ItemList[it].highlighted = (com.rockstargames.PauseMenu.TabView.FOCUS_LEVEL == 2) ? (it == this.currentSelection) : false;
		}
	}

	function set currentSelection(i)
	{
		if (this.itemType == 3)
		{
			this._selectedIndex = i;
			if (this._selectedIndex < 0)
			{
				this._selectedIndex += this.ItemList.length;
			}
			if (this._selectedIndex > this.ItemList.length - 1)
			{
				this._selectedIndex -= this.ItemList.length;
			}
			this.updateItemList();
		}
	}

	function get currentSelection()
	{
		if (this.itemType == 3)
		{
			return this._selectedIndex;
		}
		return undefined;
	}

	function get currentItem()
	{
		if (this.itemType == 3)
		{
			return this.ItemList[this.currentSelection];
		}
		return undefined;
	}
}
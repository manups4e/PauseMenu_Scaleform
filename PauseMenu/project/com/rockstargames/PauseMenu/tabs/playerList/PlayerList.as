class com.rockstargames.PauseMenu.tabs.playerList.PlayerList
{
	var _MC;
	var _parentMC;
	var DescriptionSprite;
	var EnableAnim = true;
	var AnimType = com.rockstargames.ui.tweenStar.Ease.LINEAR;
	var BodyMask;
	var scrollableContent;
	var _itemsOffset;
	var ItemList;
	var blipLayer;
	var itemCount = 0;
	var Footer;
	var _activeItem = 0;
	var _minItem;
	var _maxItem;
	var MAX_ITEMS = 10;
	var OFFSET;
	var type = "players";
	var _id;
	var _isVisible = false;

	function PlayerList(parent, offset, id)
	{
		this._id = id;
		this.OFFSET = offset;
		this._minItem = 0;
		this._maxItem = this.MAX_ITEMS;
		this.ItemList = new Array();
		this._parentMC = parent;
		this._MC = parent.CONTENT;
		this.BodyMask = this._MC.attachMovie("pauseMenuColumnBody", "Body_players", this._MC.getNextHighestDepth(), {_x:this.OFFSET});
		this.BodyMask.maskMC._height = 0;
		this.BodyMask.bgMC._height = 0;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.BodyMask.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.BodyMask.bgMC._alpha = 0;
		this.scrollableContent = this.BodyMask.createEmptyMovieClip("viewContainer", this.BodyMask.getNextHighestDepth());
		this.BodyMask.setMask(this.BodyMask.maskMC);
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;

		this.Footer = this._MC.attachMovie("MenuFooter", "footer_players", this._MC.getNextHighestDepth());
		this.Footer._visible = false;

		/*
		this.DescriptionSprite = this._MC.attachMovie("DescriptionBG", "descriptionSprite", this._MC.getNextHighestDepth());
		var _loc3_ = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
		com.rockstargames.ui.utils.Colour.Colourise(this.DescriptionSprite.bgMC,_loc3_.r,_loc3_.g,_loc3_.b,_loc3_.a);
		this.DescriptionSprite._visible = false;
		this.EnableAnim = false;
		this.AnimType = 0;
		*/
		this.EnableAnim = true;
		this.AnimType = 0;
	}

	function AddItem(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var item;
		/*
		if (id == 0)
		{
		item = new com.rockstargames.PauseMenu.tabs.playerList.PlayerItem(this, this.scrollableContent, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13);
		item.itemMC._x = item.itemMC._x - 25;
		}
		*/
		if (id == 1)
		{
			item = new com.rockstargames.PauseMenu.tabs.playerList.FriendItem(this, this.scrollableContent, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13);
		}

		item.uniqueID = this.itemCount;
		item.itemMC._y = this.ItemList.length * 23.5;
		this.itemCount = this.ItemList.push(item);
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;
		this.updateItemsDrawing();
	}

	function RemoveItem(id)
	{
		this.ItemList[id].Clear();
		this.ItemList.splice(id,1);
		this.itemCount = this.ItemList.length;
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;
		this.updateItemsDrawing();
	}

	function ScrollMenu(targetIndex, delay, end, offset)
	{
		if (end == undefined)
		{
			end = false;
		}
		var time = 0.2;
		switch (delay)
		{
			case 150 :
				time = 0.2;
				break;
			case 140 :
				time = 0.09;
				break;
			case 130 :
				time = 0.087;
				break;
			case 120 :
				time = 0.083;
				break;
			case 110 :
				time = 0.08;
				break;
			case 100 :
				time = 0.05;
				break;
			case 90 :
				time = 0.03;
				break;
			case 80 :
				time = 0.02;
				break;
			case 70 :
				time = 0.01;
				break;
			case 60 :
				time = 0.007;
				break;
			case 50 :
				time = 0.003;
				break;
		}
		if (offset != undefined)
		{
			_loc2_ = offset;
		}
		else
		{
			var _loc2_ = this.scrollableContent._y;
			switch (targetIndex)
			{
				case 1 :
					_loc2_ = _loc2_ - this.currentItem.itemMC._height;
					if (end)
					{
						_loc2_ = 0;
					}
					else
					{
						if (_loc2_ <= -this.scrollableContent._height - this.MaxHeight)
						{
							_loc2_ = -this.scrollableContent._height - this.MaxHeight;
						}
					}
					break;
				case -1 :
					_loc2_ = _loc2_ + this.currentItem.itemMC._height;
					if (end)
					{
						_loc2_ = -(this.scrollableContent._height - this.MaxHeight);
					}
					else
					{
						if (_loc2_ >= 0)
						{
							_loc2_ = 0;
						}
					}
					break;
			}
		}
		if (this.EnableAnim)
		{
			com.rockstargames.ui.tweenStar.TweenStarLite.to(this.scrollableContent,time,{_y:_loc2_, onCompleteScope:this, onComplete:this.scrollComplete, onCompleteArgs:[targetIndex, end, _loc2_], ease:this.AnimType});
		}
		else
		{
			this.scrollableContent._y = _loc2_;
		}
	}

	function scrollComplete(dir, end, posy)
	{
		if (!end)
		{
			if (dir == 1)
			{
				if (this.scrollableContent._y != this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height))
				{
					this.scrollableContent._y = this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height);
				}
			}
			else if (dir == -1)
			{
				if (this.scrollableContent._y != -this.currentItem.itemMC._y)
				{
					this.scrollableContent._y = -this.currentItem.itemMC._y;
				}
			}
		}
	}

	function GoUp(val)
	{
		var delay = val;
		if (this.itemCount > this.MAX_ITEMS)
		{
			if (this.currentSelection == 0)
			{
				this._activeItem = 1000 - (1000 % this.itemCount);
				this._activeItem += this.itemCount - 1;
				this._minItem = this.itemCount - 1 - this.MAX_ITEMS;
				this._maxItem = this.itemCount - 1;
				this.ScrollMenu(-1,delay,true);
			}
			else
			{
				this._activeItem--;
				if (this.scrollableContent._y < -this.currentItem.itemMC._y)
				{
					this.ScrollMenu(-1,delay);
					this._minItem--;
					this._maxItem--;
				}
			}
		}
		else if (this.currentSelection == 0)
		{
			this._activeItem = 1000 - (1000 % this.itemCount);
			this._activeItem += this.itemCount - 1;
			this._minItem = this.itemCount - 1 - this.MAX_ITEMS;
			this._maxItem = this.itemCount - 1;
		}
		else
		{
			this._activeItem--;
		}
		this.updateItemsDrawing();
		return this.currentSelection;
	}

	function GoDown(val)
	{
		var delay = val;
		if (this.itemCount > this.MAX_ITEMS)
		{
			if (this.currentSelection == this.itemCount - 1)
			{
				this._activeItem = 1000 - (1000 % this.itemCount);
				this._minItem = 0;
				this._maxItem = this.MAX_ITEMS;
				this.ScrollMenu(1,delay,true);
			}
			else
			{
				this._activeItem++;
				if (this.scrollableContent._y > this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height))
				{
					this.ScrollMenu(1,delay);
					this._minItem++;
					this._maxItem++;
				}
			}
		}
		else if (this.currentSelection == this.itemCount - 1)
		{
			this._activeItem = 1000 - (1000 % this.itemCount);
			this._minItem = 0;
			this._maxItem = this.MAX_ITEMS;
		}
		else
		{
			this._activeItem++;
		}
		this.updateItemsDrawing();
		return this.currentSelection;
	}

	function GoLeft()
	{
		var retVal = -1;
		this.updateItemsDrawing();
		return retVal;
	}

	function GoRight()
	{
		var retVal = -1;
		this.updateItemsDrawing();
		return retVal;
	}

	function updateItemsDrawing()
	{
		this.BodyMask._x = this.OFFSET;// cambierà in base alla richiesta (x)
		for (var item in this.ItemList)
		{
			this.ItemList[item].highlighted = false;
			if (item == 0)
			{
				this.ItemList[item].itemMC._y = 0;
			}
			else if (item > 0)
			{
				this.ItemList[item].itemMC._y = this.ItemList[item - 1].itemMC._y + this.ItemList[item - 1].itemMC._height - 7.5;
			}
			if (this._isVisible)
			{
				this.ItemList[item].panel.Visible = this.ItemList[item].Selected = this.ItemList[item].highlighted = (item == this.currentSelection);
				this.ItemList[item].panel.itemMC._x = this._parentMC.rightX + (this.ItemList[item].panel.collapsed ? 144 : 0);
			}
			else
			{
				this.ItemList[item].panel.Visible = false;
			}
		}

		//this._parentMC.missionDetails.itemMC._visible = this._parentMC.currentColumn.type != this.type || this.currentItem.panel == undefined;

		this.BodyMask.maskMC._height = this.BodyMask.bgMC._height = this.MaxHeight;
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;

		this.updateDescription();
	}

	function updateDescription()
	{
		var offset = this._itemsOffset;
		if (this.itemCount > this.MAX_ITEMS)
		{
			if (this.Footer == undefined)
			{
				this.Footer = this._MC.attachMovie("MenuFooter", "footer_settings", this._MC.getNextHighestDepth());
			}
			this.Footer._visible = this._isVisible;
			this.Footer._x = this.OFFSET;// cambierà in base alle necessità
			this.Footer._y = offset + 1;
			offset += this.Footer._height + 1;
			com.rockstargames.ui.utils.UIText.setSizedText(this.Footer.numItemsTF,this.currentSelection + 1 + "/" + this.itemCount,true,true);
		}
		else
		{
			this.Footer._visible = false;
		}

		if (this.currentItem.subtitle != undefined && this.currentItem.subtitle != "")
		{
			this.DescriptionSprite._x = this.OFFSET;// cambierà
			this.DescriptionSprite._y = offset + 2.55;
			this.DescriptionSprite._visible = this._isVisible;
			var textBlips = new com.rockstargames.ui.utils.Text();
			var format = this.DescriptionSprite.descriptionMC.descText.getTextFormat();
			//com.rockstargames.ui.utils.UIText.setDescText(this.DescriptionSprite.descriptionMC.descText,this.currentItem.subtitle,true);
			if (this.blipLayer)
			{
				this.blipLayer.removeMovieClip();
			}
			this.DescriptionSprite.descriptionMC.descText.wordWrap = true;
			this.DescriptionSprite.descriptionMC.descText.autoSize = "left";
			this.blipLayer = this.DescriptionSprite.descriptionMC.createEmptyMovieClip("blipLayer", this.DescriptionSprite.descriptionMC.getNextHighestDepth(), {_x:this.DescriptionSprite.descriptionMC.descText._x, _y:this.DescriptionSprite.descriptionMC.descText._y});
			textBlips.setTextWithIcons(this.currentItem.subtitle,this.blipLayer,this.DescriptionSprite.descriptionMC.descText,0,format.size,2,false);
			this.DescriptionSprite.descriptionMC.descText.setTextFormat(format);
			if (this.currentItem.blinkDesc)
			{
				if (this.DescriptionSprite.iMC._currentframe == 1)
				{
					this.DescriptionSprite.iMC.gotoAndPlay(2);
				}
			}
			else
			{
				this.DescriptionSprite.iMC.gotoAndStop(1);
			}
			this.DescriptionSprite.bgMC._height = this.DescriptionSprite.descriptionMC.descText.textHeight + 16;
		}
		else
		{
			this.DescriptionSprite._visible = false;
			this.DescriptionSprite.iMC.gotoAndStop(1);
		}
	}

	function set currentSelection(val)
	{
		var dir = undefined;
		if (this.itemCount == 0)
		{
			this._activeItem = 0;
			return;
		}
		this._activeItem = 1000000 - (1000000 % this.itemCount) + val;

		if (this.currentSelection > this._maxItem)
		{
			this._minItem = this.currentSelection - this.MAX_ITEMS;
			this._maxItem = this.currentSelection;
			if (this._minItem < 0)
			{
				this._minItem = 0;
			}
			dir = this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height);
		}
		else if (this.currentSelection < this._minItem)
		{
			this._minItem = this.currentSelection;
			this._maxItem = this.currentSelection + this.MAX_ITEMS;
			if (this._maxItem > this.itemCount - 1)
			{
				this._maxItem = this.itemCount - 1;
			}
			dir = -this.currentItem.itemMC._y;
		}
		this.ScrollMenu(0,150,0,dir);
		this.updateItemsDrawing();
	}

	function get currentSelection()
	{
		if (this.itemCount == 0)
		{
			return 0;
		}
		return this._activeItem % this.itemCount;
	}

	function get currentItem()
	{
		return this.ItemList[this.currentSelection];
	}

	function get MaxHeight()
	{
		var limit = this.itemCount - 1;
		if (limit > this.MAX_ITEMS)
		{
			limit = this.MAX_ITEMS;
		}
		return this.ItemList[limit].itemMC._y + this.ItemList[limit].itemMC._height;
	}

	function Clear()
	{
		for (var i in this.ItemList)
		{
			this.ItemList[i].Clear();
		}
		this.Footer.removeMovieClip();
	}

	function set IsVisible(v)
	{
		this._isVisible = v;
		this.BodyMask._visible = v;
		if (this.itemCount > this.MAX_ITEMS)
		{
			this.Footer._visible = v;
		}
		if (this.currentItem.panel)
		{
			this.currentItem.panel.Visible = v;
		}
		/*
		if (this.currentItem.subtitle != undefined && this.currentItem.subtitle != "")
		{
		this.DescriptionSprite._visible = v;
		}
		*/ 
	}
	function get IsVisible()
	{
		return this._isVisible;
	}

}
class com.rockstargames.PauseMenu.header.PauseMenuBar extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var CONTENT;
	var menuItemList = new Array();
	var visibleItems = 6;
	var totalMenuWidth = 868;
	var scrollingMenuWidth = 725;
	var menuItemWidth = 143;
	var menuItemSpacing = 2;
	var created = false;
	var menuIndex = 0;
	var startIndex = 0;
	var headerContainerMC;
	var leftArrowMouseCatcherMC;
	var rightArrowMouseCatcherMC;

	function PauseMenuBar()
	{
		super();
		this.menuItemList = new Array();
	}

	function INITIALIZE(mc, newmc)
	{
		if (newmc == undefined)
		{
			this.CONTENT = this;
		}
		else
		{
			super.INITIALISE(newmc);
		}
		this.headerContainerMC = this.CONTENT.createEmptyMovieClip("menuContainerMC", this.CONTENT.getNextHighestDepth());
	}

	function AddItem(_title)
	{
		var menuItem = com.rockstargames.PauseMenu.header.BarItem(this.headerContainerMC.attachMovie("PauseBarMenuItem", "pauseBarMenuItem" + (this.menuItemList.length + 1), this.headerContainerMC.getNextHighestDepth()));
		menuItem.label = _title;
		menuItem.menuenum = this.menuItemList.length;
		menuItem._x = menuItem.menuenum * (this.menuItemWidth + this.menuItemSpacing);
		menuItem.init();
		if (menuItem.menuenum == this.menuIndex)
		{
			menuItem.highlight = true;
		}
		else
		{
			menuItem.highlight = false;
		}
		menuItem.width = this.menuItemWidth;
		menuItem.rollover = false;
		this.menuItemList.push(menuItem);
		if (this.menuItemList.length > 6)
		{
			this.leftArrowMouseCatcherMC = this.createArrowMouseCatcher(-20 - this.menuItemSpacing, 8, 20, 20, this.onLeftArrowClick);
			this.rightArrowMouseCatcherMC = this.createArrowMouseCatcher((this.menuItemWidth + this.menuItemSpacing) * this.visibleItems, 8, 20, 20, this.onRightArrowClick);
		}
	}

	function RemItem(idx)
	{

	}

	function SelectItem(item)
	{

	}

	function createArrowMouseCatcher(x, y, w, h, mPress)
	{
		var _loc2_ = this.CONTENT.createEmptyMovieClip("arrowCatcherMC" + this.CONTENT.getNextHighestDepth(), this.CONTENT.getNextHighestDepth());
		_loc2_.beginFill(16711935,100);
		_loc2_.moveTo(0,0);
		_loc2_.lineTo(w,0);
		_loc2_.lineTo(w,h);
		_loc2_.lineTo(0,h);
		_loc2_.lineTo(0,0);
		_loc2_.endFill();
		_loc2_._visible = false;
		_loc2_._alpha = 100;
		_loc2_._x = x;
		_loc2_._y = y;
		_loc2_.onRelease = mx.utils.Delegate.create(this, mPress);
		return _loc2_;
	}

	function removeArrowMouseCatcher(arrowCatcherMC)
	{
		delete arrowCatcherMC.onRelease;
		arrowCatcherMC.removeMovieClip();
	}
	function onLeftArrowClick()
	{
		var _loc2_ = (this.menuIndex <= 0 ? this.menuItemList.length : this.menuIndex) - 1;
		this.SET_CODE_MENU_INDEX(_loc2_);
	}
	function onRightArrowClick()
	{
		var _loc2_ = (this.menuIndex + 1) % this.menuItemList.length;
		this.SET_CODE_MENU_INDEX(_loc2_);
	}

	function SET_CODE_MENU_INDEX(rollOverIndex)
	{
		com.rockstargames.ui.utils.Debug.log("SET_CODE_MENU_INDEX " + rollOverIndex);
		var _loc7_ = 0;
		var __reg7 = 0;
		if (this.menuItemList.length > this.visibleItems)
		{
			if (this.menuIndex == 0 && rollOverIndex == this.menuItemList.length - 1)
			{
				this.startIndex = this.menuItemList.length - this.visibleItems;
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			if (this.menuIndex == this.menuItemList.length - 1 && rollOverIndex == 0)
			{
				this.startIndex = 0;
				__reg7 = 0 - rollOverIndex * (this.menuItemWidth + this.menuItemSpacing);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			if (rollOverIndex >= this.startIndex + this.visibleItems)
			{
				++this.startIndex;
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.2,com.rockstargames.ui.tweenStar.Ease.CUBIC_OUT);
			}
			if (rollOverIndex < this.startIndex)
			{
				--this.startIndex;
				__reg7 = 0 - rollOverIndex * (this.menuItemWidth + this.menuItemSpacing);
				this.scrollMenu(__reg7,0.2,com.rockstargames.ui.tweenStar.Ease.CUBIC_OUT);
			}
		}
		com.rockstargames.ui.utils.Debug.log("menuIndex " + rollOverIndex);
		this.menuIndex = rollOverIndex;
		for (var i = 0; i < this.menuItemList.length; i++)
		{
			this.menuItemList[i].highlight = (i == this.menuIndex);
		}
		//com.rockstargames.ui.game.GameInterface.call("LAYOUT_CHANGED",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,0,0,rollOverIndex,1);
		var __reg8 = this.menuIndex == this.startIndex;
		var __reg9 = this.menuIndex - this.startIndex == this.visibleItems - 1;
		this.SET_HEADER_ARROWS_VISIBLE(__reg8,__reg9);
	}

	function scrollMenu(x, duration, easetype)
	{
		if (!duration || duration == 0)
		{
			duration = 0.2;
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.headerContainerMC,duration,{_x:x, ease:easetype});
	}

	function SET_HEADER_ARROWS_VISIBLE(isLeftArrowVisible, isRightArrowVisible)
	{
		com.rockstargames.ui.game.GameInterface.call("SET_HEADER_ARROW_VISIBLE",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,this.menuItemList.length > this.visibleItems,isLeftArrowVisible,isRightArrowVisible);
	}

}
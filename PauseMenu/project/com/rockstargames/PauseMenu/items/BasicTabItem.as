class com.rockstargames.PauseMenu.items.BasicTabItem extends MovieClip
{
	var itemMC;
	var blipLayer;
	var _isVisible;
	var itemTextLeft;
	var itemTextRight;
	var _type;

	function BasicTabItem(mc, param1, param2, param3, param4)
	{
		super();
		this.itemMC = mc.attachMovie("basicListItem", "basic_item_" + mc.getNextHighestDepth(), mc.getNextHighestDepth());
		//this.itemMC.bgMC._visible = false;
		this.itemMC.bgMC._alpha = 0;

		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.labelMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);

		if (this.blipLayer)
		{
			this.blipLayer.removeMovieClip();
		}
		this.itemMC.labelMC.titleTF.autoSize = true;
		this.itemMC.labelMC.titleTF.multiline = true;
		this.itemMC.labelMC.titleTF.wordWrap = true;
		var _loc3_ = new com.rockstargames.ui.utils.Text();
		this.blipLayer = this.itemMC.labelMC.createEmptyMovieClip("blipLayerMC", 1000);
		_loc3_.setTextWithIcons(param1,this.blipLayer,this.itemMC.labelMC.titleTF,0,13,3,false);

		this.snapBGGrid(this.itemMC.bgMC);
	}

	function snapBGGrid(bgMC)
	{
		var _loc2_ = this.itemMC.labelMC._y + this.itemMC.labelMC.titleTF.textHeight + 5;
		this.itemMC.bgMC._height = _loc2_;
	}

	function parseForFonts(str)
	{
		str = str.split("<C>").join("<FONT FACE=\'$Font2_cond\' SIZE=\'15\'>");
		str = str.split("</C>").join("<FONT FACE=\'$Font2\' SIZE=\'12\'>");
		return str;
	}

	function set isVisible(_v)
	{
		this._isVisible = _v;
		this.itemMC._visible = _v;
	}
	function get isVisible()
	{
		return this._isVisible;
	}
	function get Value()
	{
		return -1;
	}

}
class com.rockstargames.PauseMenu.header.BarItem extends MovieClip
{
	var _title;
	var mc;
	var tempColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_DIMMED;
	var isLocked:Boolean = false;
	var mIndex:Number = 0;
	var getNextHighestDepth;
	var PMB;
	var _alpha;
	var _highlight;
	var _menuenum;
	var _mywidth;
	var _rollover;
	var hasMouse;
	var lockMC;
	var tabMC;
	var textMC;
	var warnAlertText;
	var _parentBar;

	function BarItem()
	{
		super();
		this.textMC = this.mc.textMC;
		this.tabMC._alpha = 0;
		this.rollover = false;
		this.mycolour = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_FREEMODE;
		this.hasMouse = false;
	}

	function init()
	{
		this.addMouse();
	}

	function addMouse()
	{
		this.mc.onRelease = mx.utils.Delegate.create(this, this.mPress);
		this.mc.onRollOver = mx.utils.Delegate.create(this, this.mRollOver);
		this.mc.onRollOut = mx.utils.Delegate.create(this, this.mRollOut);
		this.mc.onDragOut = mx.utils.Delegate.create(this, this.mRollOut);
		this.hasMouse = true;
	}
	function removeMouse()
	{
		delete this.mc.onRelease;
		delete this.mc.onRollOver;
		delete this.mc.onRollOut;
		this.hasMouse = false;
	}
	function mPress()
	{
		if (!this.highlight)
		{
			this.PMB.SET_CODE_MENU_INDEX(this.mIndex);
		}
		else
		{
			this.PMB.SET_CODE_MENU_SELECT();
		}
	}
	function mRollOver()
	{
		if (!this.isLocked && !this.highlight)
		{
			this.rollover = true;
		}
	}
	function mRollOut()
	{
		if (!this.isLocked)
		{
			this.rollover = false;
		}
	}

	function set label(str)
	{
		this._title = str;
		com.rockstargames.ui.utils.UIText.setSizedText(this.textMC.labelTF,str,true,false);
		this.textMC.labelTF._width = this.width;
		this.textMC.labelTF._x = 0;
	}

	function get label()
	{
		return this._title;
	}

	function set highlight(h)
	{
		var __reg3 = new com.rockstargames.ui.utils.HudColour();
		var __reg4 = new com.rockstargames.ui.utils.HudColour();
		var __reg2 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg3);
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg4);
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg2);
		if (h)
		{
			this.tabMC._alpha = 100;
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.bgMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.textMC,__reg3.r,__reg3.g,__reg3.b,__reg3.a);
			if (this.isLocked)
			{
				com.rockstargames.ui.utils.Colour.Colourise(this.lockMC,__reg3.r,__reg3.g,__reg3.b,__reg3.a);
			}
		}
		else
		{
			this.tabMC._alpha = 0;
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.bgMC,__reg4.r,__reg4.g,__reg4.b,__reg4.a);
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.textMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			if (this.isLocked)
			{
				com.rockstargames.ui.utils.Colour.Colourise(this.lockMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			}
		}
		this._highlight = h;
	}

	function get highlight()
	{
		return this._highlight;
	}

	function set mycolour(c)
	{
		var __reg3 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(c,__reg3);
		com.rockstargames.ui.utils.Colour.Colourise(this.tabMC,__reg3.r,__reg3.g,__reg3.b,!this._highlight ? 0 : 100);
	}

	function set locked(l)
	{
		this.isLocked = Boolean(l);
		this.lockMC._alpha = this.isLocked ? 100 : 0;
		this._alpha = this.isLocked ? 50 : 100;
	}

	function set bespokeColour(cID)
	{
		if (cID != undefined && cID != false)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.mc.bgMC,cID);
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.mc.textMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		}
	}

	function setAlertText(warnStr, col)
	{
		if (this.warnAlertText)
		{
			this.warnAlertText.removeMovieClip();
		}
		if (warnStr != "")
		{
			this.warnAlertText = com.rockstargames.ui.components.UITextField(this.attachMovie("uiTextField", "uiTF", this.getNextHighestDepth(), {_y:1}));
			this.warnAlertText.init(17,com.rockstargames.gtav.utils.GTAVUIConfig.CONDENSED_FONT_NOT_GAMERNAME,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,true);
			this.warnAlertText.setText(warnStr);
			this.warnAlertText.setBgColour(col);
			this.warnAlertText._x = this.mc.bgMC._width * 0.5 + this.textMC.labelTF.textWidth * 0.5 + 5;
			this.warnAlertText._y = 7;
		}
	}

	function set width(w)
	{
		this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = this._mywidth = w;
		this.realignText();
	}

	function get width()
	{
		return this._mywidth;
	}

	function set rollover(h)
	{
		if (h)
		{
			this.mc.rolloverMC._alpha = 20;
		}
		else
		{
			this.mc.rolloverMC._alpha = 0;
		}
		this._rollover = h;
	}

	function set menuenum(m)
	{
		this._menuenum = m;
	}
	function get menuenum()
	{
		return this._menuenum;
	}

	function realignText(widthSpan)
	{
		var __reg2 = this.width();
		if (widthSpan)
		{
			var __reg4 = 2;
			__reg2 = this._mywidth * widthSpan + __reg4 * (widthSpan - 1);
			this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = __reg2;
		}
		this.textMC.labelTF._x = __reg2 / 2 - this.textMC.labelTF._width / 2 - 1;
		this.lockMC._x = this.textMC.labelTF._x + this.textMC.labelTF._width + 5;
	}

	function resizeTabPx(widthSpanPx)
	{
		this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = widthSpanPx;
		this.textMC.labelTF._x = widthSpanPx / 2 - this.textMC.labelTF._width / 2;
		this.lockMC._x = this.textMC.labelTF._x + this.textMC.labelTF._width + 5;
		if (this.warnAlertText)
		{
			this.warnAlertText._x = this.mc.bgMC._width * 0.5 + this.textMC.labelTF.textWidth * 0.5 + 5;
		}
	}

}
class mx.utils.Delegate extends Object
{
   function Delegate(f)
   {
      super();
      this.func = f;
   }
   function createDelegate(obj)
   {
      return mx.utils.Delegate.create(obj,this.func);
   }
   static function create(obj, func)
   {
      var _loc2_ = function()
      {
         var _loc3_ = arguments.callee.target;
         var _loc2_ = arguments.callee.func;
         return _loc2_.apply(_loc3_,arguments);
      };
      _loc2_.target = obj;
      _loc2_.func = func;
      return _loc2_;
   }
}

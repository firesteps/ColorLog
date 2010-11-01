package local.logging.targets
{
import mx.logging.AbstractTarget;
import mx.logging.ILogger;
import mx.logging.LogEvent;
import mx.logging.LogEventLevel;

import net.saqoosha.colorlog.ColorLog;
import net.saqoosha.colorlog.SGR;
import net.saqoosha.colorlog.ctrace;

/**
 *  Provides a logger target that uses the global <code>trace()</code> method to output log messages with special symbols.
 *  
 *  <p>To view <code>trace()</code> method output, you must be running the 
 *  debugger version of Flash Player or AIR Debug Launcher.</p>
 *  
 *  <p>The debugger version of Flash Player and AIR Debug Launcher send output from the <code>trace()</code> method 
 *  to the flashlog.txt file. The default location of this file is the same directory as 
 *  the mm.cfg file. You can customize the location of this file by using the <code>TraceOutputFileName</code> 
 *  property in the mm.cfg file. You must also set <code>TraceOutputFileEnable</code> to 1 in your mm.cfg file.</p>
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public class ColorTraceTarget extends AbstractTarget
{
	
	private var _includeTime:Boolean;
	
	/**
	 *  Indicates if the time should be added to the trace.
	 */
	public function get includeTime():Boolean{
		return _includeTime;
	}
	
	public function set includeTime(value:Boolean):void{
		_includeTime = value;
	}
	
	private var _includeDate:Boolean;
	
	/**
	 *  Indicates if the date should be added to the trace.
	 */
	public function get includeDate():Boolean{
		return _includeDate;
	}
	
	public function set includeDate(value:Boolean):void{
		_includeDate = value;
	}
	
	private var _includeCategory:Boolean;
	
	/**
	 *  Indicates if the category for this target should added to the trace.
	 */
	public function get includeCategory():Boolean{
		return _includeCategory;
	}
	
	public function set includeCategory(value:Boolean):void{
		_includeCategory = value;
	}
	
	private var _includeLevel:Boolean;
	
	/**
	 *  Indicates if the level for the event should added to the trace.
	 */
	public function get includeLevel():Boolean{
		return _includeLevel;
	}
	
	public function set includeLevel(value:Boolean):void{
		_includeLevel = value;
	}
	
	private var _fieldSeparator:String = " ";
	
	/**
	 *  The separator string to use between fields (the default is " ")
	 */
	public function get fieldSeparator():String{
		return _fieldSeparator;
	}
	
	public function set fieldSeparator(value:String):void{
		_fieldSeparator = value;
	}
	
	private var _dateColor:Array = [];
	
	/**
	 *  Date will be displayed with this color in log message.
	 * 
	 *  @see net.saqoosha.SGR
	 */
	public function get dateColor():Array{
		return _dateColor;
	}
	
	public function set dateColor(value:Array):void{
		_dateColor = value;
	}
	
	private var _categoryColor:Array = [SGR.INTENSITY_BOLD];
	
	/**
	 * Category will be displayed with this color in log message .
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get categoryColor():Array{
		return _categoryColor;
	}
	
	public function set categoryColor(value:Array):void{
		_categoryColor = value;
	}
	
	private var _infoColor:Array = [SGR.FG_BRIGHT_GREEN];
	
	/**
	 * Info message will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get infoColor():Array{
		return _infoColor;
	}
	
	public function set infoColor(value:Array):void{
		_infoColor = value;
	}
	
	private var _warnColor:Array = [SGR.FG_BRIGHT_YELLOW];
	
	/**
	 * Warning message will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get warnColor():Array{
		return _warnColor;
	}
	
	public function set warnColor(value:Array):void{
		_warnColor = value;
	}
	
	private var _debugColor:Array = [SGR.FG_BRIGHT_MAGENTA];
	
	/**
	 * Debug message will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get debugColor():Array{
		return _debugColor;
	}
	
	public function set debugColor(value:Array):void{
		_debugColor = value;
	}

	private var _errorColor:Array = [SGR.FG_BRIGHT_RED];
	
	/**
	 * Error message will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get errorColor():Array{
		return _errorColor;
	}
	
	public function set errorColor(value:Array):void{
		_errorColor = value;
	}

	private var _fatalColor:Array = [SGR.FG_BRIGHT_RED, SGR.UNDERLINE_SINGLE, SGR.INTENSITY_BOLD];
	
	/**
	 * Fatal message will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get fatalColor():Array{
		return _fatalColor;
	}
	
	public function set fatalColor(value:Array):void{
		_fatalColor = value;
	}

	private var _commonColor:Array = [];
	
	/**
	 * Message with custom log level will be displayed with this color in log.
	 * 
	 * @see net.saqoosha.SGR
	 */
	public function get commonColor():Array{
		return _infoColor;
	}
	
	public function set commonColor(value:Array):void{
		_infoColor = value;
	}

	
	public function ColorTraceTarget(includeCategory:Boolean = true,
									 includeLevel:Boolean = false,
									 includeTime:Boolean = false, 
									 includeDate:Boolean = false){
		super();
		this.includeTime = includeTime;
		this.includeDate = includeDate;
		this.includeCategory = includeCategory;
		this.includeLevel = includeLevel;
	}

	/**
	 *  This method handles a <code>LogEvent</code> from an associated logger.
	 *  A target uses this method to translate the event into the appropriate
	 *  format for transmission, storage, or display.
	 *  This method is called only if the event's level is in range of the
	 *  target's level.
	 * 
	 *  @param event The <code>LogEvent</code> handled by this method.
	 */		
	override public function logEvent(event:LogEvent):void{
		var date:String = ""
		if (includeDate || includeTime)
		{
			var d:Date = new Date();
			if (includeDate)
			{
				date = Number(d.getMonth() + 1).toString() + "/" +
					d.getDate().toString() + "/" + 
					d.getFullYear() + fieldSeparator;
			}   
			if (includeTime)
			{
				date += padTime(d.getHours()) + ":" +
					padTime(d.getMinutes()) + ":" +
					padTime(d.getSeconds()) + "." +
					padTime(d.getMilliseconds(), true) + fieldSeparator;
			}
		}
		
		var level:String = "";
		if (includeLevel)
		{
			level = "[" + LogEvent.getLevelString(event.level) +
				"]" + fieldSeparator;
		}
		
		var category:String = includeCategory ?
			ILogger(event.target).category + fieldSeparator :
			"";
		
		logLevel(date, category, level, event.message, event.level);
		
	}
	
	/**
	 *  Descendants of this class should override this method to direct the 
	 *  specified message to the desired output.
	 *
	 *  @param  message String containing preprocessed log message which may
	 *              include time, date, category, etc. based on property settings,
	 *              such as <code>includeDate</code>, <code>includeCategory</code>,
	 *          etc.
	 *  @param  level Contain level (LogEvent.level) of log message.
	 */
	protected function logLevel(date:String, category:String, levelString:String, message:String, level:int):void{
		ColorLog.setColor.apply(null, dateColor);
		ColorLog.out(date);
		ColorLog.setColor(SGR.RESET);
		ColorLog.setColor.apply(null, categoryColor);
		ColorLog.out(category);
		ColorLog.setColor([SGR.RESET, SGR.INTENSITY_NORMAL]);
		switch (level){
			case LogEventLevel.INFO:
				ColorLog.setColor.apply(null, infoColor);
				break;
			case LogEventLevel.WARN:
				ColorLog.setColor.apply(null, warnColor);
				break;
			case LogEventLevel.DEBUG:
				ColorLog.setColor.apply(null, debugColor);
				break;
			case LogEventLevel.ERROR:
				ColorLog.setColor.apply(null, errorColor);
				break;
			case LogEventLevel.FATAL:
				ColorLog.setColor.apply(null, fatalColor);
				break;
			default:
				ColorLog.setColor.apply(null, commonColor);
		}
		ColorLog.out(levelString + message);
		ColorLog.flush();
	}
	
	
	
	/**
	 *  @private
	 */
	private function padTime(num:Number, millis:Boolean = false):String
	{
		if (millis)
		{
			if (num < 10)
				return "00" + num.toString();
			else if (num < 100)
				return "0" + num.toString();
			else 
				return num.toString();
		}
		else
		{
			return num > 9 ? num.toString() : "0" + num.toString();
		}
	}

}
}
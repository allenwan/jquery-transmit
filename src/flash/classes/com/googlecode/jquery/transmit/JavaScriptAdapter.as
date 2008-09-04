﻿package com.googlecode.jquery.transmit {		import flash.display.DisplayObject;	import flash.display.LoaderInfo;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.errors.IOError;	import flash.events.Event;	import flash.external.ExternalInterface;	import flash.system.Security;		public class JavaScriptAdapter extends Sprite {				protected var elementId:String;		protected var javaScriptEventHandler:String;		private var comp:DisplayObject;				public function JavaScriptAdapter() {			super();			if (stage) {				stage.addEventListener(Event.RESIZE, onStageResize);				stage.scaleMode = StageScaleMode.NO_SCALE;				stage.align = StageAlign.TOP_LEFT;			}			if (ExternalInterface.available) {				init();				dispatchEventToJavaScript({type:"swfReady"});			} else {				throw new IOError("ExternalInterface is not available.");			}		}				/* ----- API functions ----- */				protected function init():void {			this.elementId = LoaderInfo(this.root.loaderInfo).parameters["elementId"];			this.javaScriptEventHandler = LoaderInfo(this.root.loaderInfo).parameters["eventHandler"];			var allowedDomain:String = LoaderInfo(this.root.loaderInfo).parameters["allowedDomain"];			if(allowedDomain) {				Security.allowDomain(allowedDomain);			}		}				protected function dispatchEventToJavaScript(event:Object):void {			try {				ExternalInterface.call(this.javaScriptEventHandler, this.elementId, event);			} catch (error:SecurityError) {				trace("Warning: Cannot establish communication between Flash and JavaScript!");			}		}				protected function onStageResize(event:Event):void {			resizeComponent();		}				protected function resizeComponent():void {			if (component) {				component.x = component.y = 0;				component.width = stage.stageWidth;				component.height = stage.stageHeight;			}		}				/* ----- Accessor/Mutator pairs ----- */				protected function get component():DisplayObject {			return comp;		}				protected function set component(comp:DisplayObject):void {			this.comp = comp;			resizeComponent();		}	}}
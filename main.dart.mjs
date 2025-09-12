// Compiles a dart2wasm-generated main module from `source` which can then
// instantiatable via the `instantiate` method.
//
// `source` needs to be a `Response` object (or promise thereof) e.g. created
// via the `fetch()` JS API.
export async function compileStreaming(source) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(
      await WebAssembly.compileStreaming(source, builtins), builtins);
}

// Compiles a dart2wasm-generated wasm modules from `bytes` which is then
// instantiatable via the `instantiate` method.
export async function compile(bytes) {
  const builtins = {builtins: ['js-string']};
  return new CompiledApp(await WebAssembly.compile(bytes, builtins), builtins);
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export async function instantiate(modulePromise, importObjectPromise) {
  var moduleOrCompiledApp = await modulePromise;
  if (!(moduleOrCompiledApp instanceof CompiledApp)) {
    moduleOrCompiledApp = new CompiledApp(moduleOrCompiledApp);
  }
  const instantiatedApp = await moduleOrCompiledApp.instantiate(await importObjectPromise);
  return instantiatedApp.instantiatedModule;
}

// DEPRECATED: Please use `compile` or `compileStreaming` to get a compiled app,
// use `instantiate` method to get an instantiated app and then call
// `invokeMain` to invoke the main function.
export const invoke = (moduleInstance, ...args) => {
  moduleInstance.exports.$invokeMain(args);
}

class CompiledApp {
  constructor(module, builtins) {
    this.module = module;
    this.builtins = builtins;
  }

  // The second argument is an options object containing:
  // `loadDeferredWasm` is a JS function that takes a module name matching a
  //   wasm file produced by the dart2wasm compiler and returns the bytes to
  //   load the module. These bytes can be in either a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`.
  // `loadDynamicModule` is a JS function that takes two string names matching,
  //   in order, a wasm file produced by the dart2wasm compiler during dynamic
  //   module compilation and a corresponding js file produced by the same
  //   compilation. It should return a JS Array containing 2 elements. The first
  //   should be the bytes for the wasm module in a format supported by
  //   `WebAssembly.compile` or `WebAssembly.compileStreaming`. The second
  //   should be the result of using the JS 'import' API on the js file path.
  async instantiate(additionalImports, {loadDeferredWasm, loadDynamicModule} = {}) {
    let dartInstance;

    // Prints to the console
    function printToConsole(value) {
      if (typeof dartPrint == "function") {
        dartPrint(value);
        return;
      }
      if (typeof console == "object" && typeof console.log != "undefined") {
        console.log(value);
        return;
      }
      if (typeof print == "function") {
        print(value);
        return;
      }

      throw "Unable to print message: " + value;
    }

    // A special symbol attached to functions that wrap Dart functions.
    const jsWrappedDartFunctionSymbol = Symbol("JSWrappedDartFunction");

    function finalizeWrapper(dartFunction, wrapped) {
      wrapped.dartFunction = dartFunction;
      wrapped[jsWrappedDartFunctionSymbol] = true;
      return wrapped;
    }

    // Imports
    const dart2wasm = {
            _4: (o, c) => o instanceof c,
      _7: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._7(f,arguments.length,x0) }),
      _8: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._8(f,arguments.length,x0,x1) }),
      _37: x0 => new Array(x0),
      _39: x0 => x0.length,
      _41: (x0,x1) => x0[x1],
      _42: (x0,x1,x2) => { x0[x1] = x2 },
      _43: x0 => new Promise(x0),
      _45: (x0,x1,x2) => new DataView(x0,x1,x2),
      _47: x0 => new Int8Array(x0),
      _48: (x0,x1,x2) => new Uint8Array(x0,x1,x2),
      _49: x0 => new Uint8Array(x0),
      _51: x0 => new Uint8ClampedArray(x0),
      _53: x0 => new Int16Array(x0),
      _55: x0 => new Uint16Array(x0),
      _57: x0 => new Int32Array(x0),
      _59: x0 => new Uint32Array(x0),
      _61: x0 => new Float32Array(x0),
      _63: x0 => new Float64Array(x0),
      _65: (x0,x1,x2) => x0.call(x1,x2),
      _70: (decoder, codeUnits) => decoder.decode(codeUnits),
      _71: () => new TextDecoder("utf-8", {fatal: true}),
      _72: () => new TextDecoder("utf-8", {fatal: false}),
      _73: (s) => +s,
      _74: x0 => new Uint8Array(x0),
      _75: (x0,x1,x2) => x0.set(x1,x2),
      _76: (x0,x1) => x0.transferFromImageBitmap(x1),
      _78: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._78(f,arguments.length,x0) }),
      _79: x0 => new window.FinalizationRegistry(x0),
      _80: (x0,x1,x2,x3) => x0.register(x1,x2,x3),
      _81: (x0,x1) => x0.unregister(x1),
      _82: (x0,x1,x2) => x0.slice(x1,x2),
      _83: (x0,x1) => x0.decode(x1),
      _84: (x0,x1) => x0.segment(x1),
      _85: () => new TextDecoder(),
      _87: x0 => x0.click(),
      _88: x0 => x0.buffer,
      _89: x0 => x0.wasmMemory,
      _90: () => globalThis.window._flutter_skwasmInstance,
      _91: x0 => x0.rasterStartMilliseconds,
      _92: x0 => x0.rasterEndMilliseconds,
      _93: x0 => x0.imageBitmaps,
      _120: x0 => x0.remove(),
      _121: (x0,x1) => x0.append(x1),
      _122: (x0,x1,x2) => x0.insertBefore(x1,x2),
      _123: (x0,x1) => x0.querySelector(x1),
      _125: (x0,x1) => x0.removeChild(x1),
      _203: x0 => x0.stopPropagation(),
      _204: x0 => x0.preventDefault(),
      _206: (x0,x1,x2,x3) => x0.addEventListener(x1,x2,x3),
      _251: x0 => x0.unlock(),
      _252: x0 => x0.getReader(),
      _253: (x0,x1,x2) => x0.addEventListener(x1,x2),
      _254: (x0,x1,x2) => x0.removeEventListener(x1,x2),
      _255: (x0,x1) => x0.item(x1),
      _256: x0 => x0.next(),
      _257: x0 => x0.now(),
      _258: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._258(f,arguments.length,x0) }),
      _259: (x0,x1) => x0.addListener(x1),
      _260: (x0,x1) => x0.removeListener(x1),
      _261: (x0,x1) => x0.matchMedia(x1),
      _262: (x0,x1) => x0.revokeObjectURL(x1),
      _263: x0 => x0.close(),
      _264: (x0,x1,x2,x3,x4) => ({type: x0,data: x1,premultiplyAlpha: x2,colorSpaceConversion: x3,preferAnimation: x4}),
      _265: x0 => new window.ImageDecoder(x0),
      _266: x0 => ({frameIndex: x0}),
      _267: (x0,x1) => x0.decode(x1),
      _268: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._268(f,arguments.length,x0) }),
      _269: (x0,x1) => x0.getModifierState(x1),
      _270: (x0,x1) => x0.removeProperty(x1),
      _271: (x0,x1) => x0.prepend(x1),
      _272: x0 => new Intl.Locale(x0),
      _273: x0 => x0.disconnect(),
      _274: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._274(f,arguments.length,x0) }),
      _275: (x0,x1) => x0.getAttribute(x1),
      _276: (x0,x1) => x0.contains(x1),
      _277: x0 => x0.blur(),
      _278: x0 => x0.hasFocus(),
      _279: (x0,x1) => x0.hasAttribute(x1),
      _280: (x0,x1) => x0.getModifierState(x1),
      _281: (x0,x1) => x0.appendChild(x1),
      _282: (x0,x1) => x0.createTextNode(x1),
      _283: (x0,x1) => x0.removeAttribute(x1),
      _284: x0 => x0.getBoundingClientRect(),
      _285: (x0,x1) => x0.observe(x1),
      _286: x0 => x0.disconnect(),
      _287: (x0,x1) => x0.closest(x1),
      _709: () => globalThis.window.flutterConfiguration,
      _711: x0 => x0.assetBase,
      _717: x0 => x0.debugShowSemanticsNodes,
      _718: x0 => x0.hostElement,
      _719: x0 => x0.multiViewEnabled,
      _720: x0 => x0.nonce,
      _722: x0 => x0.fontFallbackBaseUrl,
      _732: x0 => x0.console,
      _733: x0 => x0.devicePixelRatio,
      _734: x0 => x0.document,
      _735: x0 => x0.history,
      _736: x0 => x0.innerHeight,
      _737: x0 => x0.innerWidth,
      _738: x0 => x0.location,
      _739: x0 => x0.navigator,
      _740: x0 => x0.visualViewport,
      _741: x0 => x0.performance,
      _743: x0 => x0.URL,
      _745: (x0,x1) => x0.getComputedStyle(x1),
      _746: x0 => x0.screen,
      _747: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._747(f,arguments.length,x0) }),
      _748: (x0,x1) => x0.requestAnimationFrame(x1),
      _753: (x0,x1) => x0.warn(x1),
      _756: x0 => globalThis.parseFloat(x0),
      _757: () => globalThis.window,
      _758: () => globalThis.Intl,
      _759: () => globalThis.Symbol,
      _760: (x0,x1,x2,x3,x4) => globalThis.createImageBitmap(x0,x1,x2,x3,x4),
      _762: x0 => x0.clipboard,
      _763: x0 => x0.maxTouchPoints,
      _764: x0 => x0.vendor,
      _765: x0 => x0.language,
      _766: x0 => x0.platform,
      _767: x0 => x0.userAgent,
      _768: (x0,x1) => x0.vibrate(x1),
      _769: x0 => x0.languages,
      _770: x0 => x0.documentElement,
      _771: (x0,x1) => x0.querySelector(x1),
      _774: (x0,x1) => x0.createElement(x1),
      _777: (x0,x1) => x0.createEvent(x1),
      _778: x0 => x0.activeElement,
      _781: x0 => x0.head,
      _782: x0 => x0.body,
      _784: (x0,x1) => { x0.title = x1 },
      _787: x0 => x0.visibilityState,
      _788: () => globalThis.document,
      _789: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._789(f,arguments.length,x0) }),
      _790: (x0,x1) => x0.dispatchEvent(x1),
      _798: x0 => x0.target,
      _800: x0 => x0.timeStamp,
      _801: x0 => x0.type,
      _803: (x0,x1,x2,x3) => x0.initEvent(x1,x2,x3),
      _810: x0 => x0.firstChild,
      _814: x0 => x0.parentElement,
      _816: (x0,x1) => { x0.textContent = x1 },
      _817: x0 => x0.parentNode,
      _819: x0 => x0.isConnected,
      _823: x0 => x0.firstElementChild,
      _825: x0 => x0.nextElementSibling,
      _826: x0 => x0.clientHeight,
      _827: x0 => x0.clientWidth,
      _828: x0 => x0.offsetHeight,
      _829: x0 => x0.offsetWidth,
      _830: x0 => x0.id,
      _831: (x0,x1) => { x0.id = x1 },
      _834: (x0,x1) => { x0.spellcheck = x1 },
      _835: x0 => x0.tagName,
      _836: x0 => x0.style,
      _838: (x0,x1) => x0.querySelectorAll(x1),
      _839: (x0,x1,x2) => x0.setAttribute(x1,x2),
      _840: x0 => x0.tabIndex,
      _841: (x0,x1) => { x0.tabIndex = x1 },
      _842: (x0,x1) => x0.focus(x1),
      _843: x0 => x0.scrollTop,
      _844: (x0,x1) => { x0.scrollTop = x1 },
      _845: x0 => x0.scrollLeft,
      _846: (x0,x1) => { x0.scrollLeft = x1 },
      _847: x0 => x0.classList,
      _849: (x0,x1) => { x0.className = x1 },
      _851: (x0,x1) => x0.getElementsByClassName(x1),
      _852: (x0,x1) => x0.attachShadow(x1),
      _855: x0 => x0.computedStyleMap(),
      _856: (x0,x1) => x0.get(x1),
      _862: (x0,x1) => x0.getPropertyValue(x1),
      _863: (x0,x1,x2,x3) => x0.setProperty(x1,x2,x3),
      _864: x0 => x0.offsetLeft,
      _865: x0 => x0.offsetTop,
      _866: x0 => x0.offsetParent,
      _868: (x0,x1) => { x0.name = x1 },
      _869: x0 => x0.content,
      _870: (x0,x1) => { x0.content = x1 },
      _874: (x0,x1) => { x0.src = x1 },
      _875: x0 => x0.naturalWidth,
      _876: x0 => x0.naturalHeight,
      _880: (x0,x1) => { x0.crossOrigin = x1 },
      _882: (x0,x1) => { x0.decoding = x1 },
      _883: x0 => x0.decode(),
      _888: (x0,x1) => { x0.nonce = x1 },
      _893: (x0,x1) => { x0.width = x1 },
      _895: (x0,x1) => { x0.height = x1 },
      _898: (x0,x1) => x0.getContext(x1),
      _962: (x0,x1) => x0.fetch(x1),
      _963: x0 => x0.status,
      _965: x0 => x0.body,
      _966: x0 => x0.arrayBuffer(),
      _969: x0 => x0.read(),
      _970: x0 => x0.value,
      _971: x0 => x0.done,
      _978: x0 => x0.name,
      _979: x0 => x0.x,
      _980: x0 => x0.y,
      _983: x0 => x0.top,
      _984: x0 => x0.right,
      _985: x0 => x0.bottom,
      _986: x0 => x0.left,
      _998: x0 => x0.height,
      _999: x0 => x0.width,
      _1000: x0 => x0.scale,
      _1001: (x0,x1) => { x0.value = x1 },
      _1004: (x0,x1) => { x0.placeholder = x1 },
      _1006: (x0,x1) => { x0.name = x1 },
      _1007: x0 => x0.selectionDirection,
      _1008: x0 => x0.selectionStart,
      _1009: x0 => x0.selectionEnd,
      _1012: x0 => x0.value,
      _1014: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1015: x0 => x0.readText(),
      _1016: (x0,x1) => x0.writeText(x1),
      _1018: x0 => x0.altKey,
      _1019: x0 => x0.code,
      _1020: x0 => x0.ctrlKey,
      _1021: x0 => x0.key,
      _1022: x0 => x0.keyCode,
      _1023: x0 => x0.location,
      _1024: x0 => x0.metaKey,
      _1025: x0 => x0.repeat,
      _1026: x0 => x0.shiftKey,
      _1027: x0 => x0.isComposing,
      _1029: x0 => x0.state,
      _1030: (x0,x1) => x0.go(x1),
      _1032: (x0,x1,x2,x3) => x0.pushState(x1,x2,x3),
      _1033: (x0,x1,x2,x3) => x0.replaceState(x1,x2,x3),
      _1034: x0 => x0.pathname,
      _1035: x0 => x0.search,
      _1036: x0 => x0.hash,
      _1040: x0 => x0.state,
      _1043: (x0,x1) => x0.createObjectURL(x1),
      _1045: x0 => new Blob(x0),
      _1047: x0 => new MutationObserver(x0),
      _1048: (x0,x1,x2) => x0.observe(x1,x2),
      _1049: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1049(f,arguments.length,x0,x1) }),
      _1052: x0 => x0.attributeName,
      _1053: x0 => x0.type,
      _1054: x0 => x0.matches,
      _1055: x0 => x0.matches,
      _1059: x0 => x0.relatedTarget,
      _1061: x0 => x0.clientX,
      _1062: x0 => x0.clientY,
      _1063: x0 => x0.offsetX,
      _1064: x0 => x0.offsetY,
      _1067: x0 => x0.button,
      _1068: x0 => x0.buttons,
      _1069: x0 => x0.ctrlKey,
      _1073: x0 => x0.pointerId,
      _1074: x0 => x0.pointerType,
      _1075: x0 => x0.pressure,
      _1076: x0 => x0.tiltX,
      _1077: x0 => x0.tiltY,
      _1078: x0 => x0.getCoalescedEvents(),
      _1081: x0 => x0.deltaX,
      _1082: x0 => x0.deltaY,
      _1083: x0 => x0.wheelDeltaX,
      _1084: x0 => x0.wheelDeltaY,
      _1085: x0 => x0.deltaMode,
      _1092: x0 => x0.changedTouches,
      _1095: x0 => x0.clientX,
      _1096: x0 => x0.clientY,
      _1099: x0 => x0.data,
      _1101: (x0,x1) => { x0.disabled = x1 },
      _1104: (x0,x1) => { x0.type = x1 },
      _1105: (x0,x1) => { x0.max = x1 },
      _1106: (x0,x1) => { x0.min = x1 },
      _1107: x0 => x0.value,
      _1108: (x0,x1) => { x0.value = x1 },
      _1109: x0 => x0.disabled,
      _1110: (x0,x1) => { x0.disabled = x1 },
      _1111: (x0,x1) => { x0.placeholder = x1 },
      _1114: (x0,x1) => { x0.name = x1 },
      _1116: (x0,x1) => { x0.autocomplete = x1 },
      _1117: x0 => x0.selectionDirection,
      _1118: x0 => x0.selectionStart,
      _1120: x0 => x0.selectionEnd,
      _1123: (x0,x1,x2) => x0.setSelectionRange(x1,x2),
      _1124: (x0,x1) => x0.add(x1),
      _1127: (x0,x1) => { x0.noValidate = x1 },
      _1128: (x0,x1) => { x0.method = x1 },
      _1129: (x0,x1) => { x0.action = x1 },
      _1155: x0 => x0.orientation,
      _1156: x0 => x0.width,
      _1157: x0 => x0.height,
      _1158: (x0,x1) => x0.lock(x1),
      _1177: x0 => new ResizeObserver(x0),
      _1180: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1180(f,arguments.length,x0,x1) }),
      _1188: x0 => x0.length,
      _1189: x0 => x0.iterator,
      _1190: x0 => x0.Segmenter,
      _1191: x0 => x0.v8BreakIterator,
      _1192: (x0,x1) => new Intl.Segmenter(x0,x1),
      _1194: x0 => x0.language,
      _1195: x0 => x0.script,
      _1196: x0 => x0.region,
      _1214: x0 => x0.done,
      _1215: x0 => x0.value,
      _1216: x0 => x0.index,
      _1220: (x0,x1) => new Intl.v8BreakIterator(x0,x1),
      _1221: (x0,x1) => x0.adoptText(x1),
      _1222: x0 => x0.first(),
      _1223: x0 => x0.next(),
      _1224: x0 => x0.current(),
      _1235: x0 => x0.hostElement,
      _1236: x0 => x0.viewConstraints,
      _1239: x0 => x0.maxHeight,
      _1240: x0 => x0.maxWidth,
      _1241: x0 => x0.minHeight,
      _1242: x0 => x0.minWidth,
      _1243: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1243(f,arguments.length,x0) }),
      _1244: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1244(f,arguments.length,x0) }),
      _1245: (x0,x1) => ({addView: x0,removeView: x1}),
      _1248: x0 => x0.loader,
      _1249: () => globalThis._flutter,
      _1250: (x0,x1) => x0.didCreateEngineInitializer(x1),
      _1251: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1251(f,arguments.length,x0) }),
      _1252: f => finalizeWrapper(f, function() { return dartInstance.exports._1252(f,arguments.length) }),
      _1253: (x0,x1) => ({initializeEngine: x0,autoStart: x1}),
      _1256: f => finalizeWrapper(f, function(x0) { return dartInstance.exports._1256(f,arguments.length,x0) }),
      _1257: x0 => ({runApp: x0}),
      _1259: f => finalizeWrapper(f, function(x0,x1) { return dartInstance.exports._1259(f,arguments.length,x0,x1) }),
      _1260: x0 => x0.length,
      _1261: () => globalThis.window.ImageDecoder,
      _1262: x0 => x0.tracks,
      _1264: x0 => x0.completed,
      _1266: x0 => x0.image,
      _1272: x0 => x0.displayWidth,
      _1273: x0 => x0.displayHeight,
      _1274: x0 => x0.duration,
      _1277: x0 => x0.ready,
      _1278: x0 => x0.selectedTrack,
      _1279: x0 => x0.repetitionCount,
      _1280: x0 => x0.frameCount,
      _1323: () => globalThis.hideSplash(),
      _1346: (x0,x1,x2,x3) => x0.open(x1,x2,x3),
      _1354: Date.now,
      _1356: s => new Date(s * 1000).getTimezoneOffset() * 60,
      _1357: s => {
        if (!/^\s*[+-]?(?:Infinity|NaN|(?:\.\d+|\d+(?:\.\d*)?)(?:[eE][+-]?\d+)?)\s*$/.test(s)) {
          return NaN;
        }
        return parseFloat(s);
      },
      _1358: () => {
        let stackString = new Error().stack.toString();
        let frames = stackString.split('\n');
        let drop = 2;
        if (frames[0] === 'Error') {
            drop += 1;
        }
        return frames.slice(drop).join('\n');
      },
      _1359: () => typeof dartUseDateNowForTicks !== "undefined",
      _1360: () => 1000 * performance.now(),
      _1361: () => Date.now(),
      _1364: () => new WeakMap(),
      _1365: (map, o) => map.get(o),
      _1366: (map, o, v) => map.set(o, v),
      _1367: x0 => new WeakRef(x0),
      _1368: x0 => x0.deref(),
      _1375: () => globalThis.WeakRef,
      _1379: s => JSON.stringify(s),
      _1380: s => printToConsole(s),
      _1381: (o, p, r) => o.replaceAll(p, () => r),
      _1383: Function.prototype.call.bind(String.prototype.toLowerCase),
      _1384: s => s.toUpperCase(),
      _1385: s => s.trim(),
      _1386: s => s.trimLeft(),
      _1387: s => s.trimRight(),
      _1388: (string, times) => string.repeat(times),
      _1389: Function.prototype.call.bind(String.prototype.indexOf),
      _1390: (s, p, i) => s.lastIndexOf(p, i),
      _1391: (string, token) => string.split(token),
      _1392: Object.is,
      _1393: o => o instanceof Array,
      _1394: (a, i) => a.push(i),
      _1398: a => a.pop(),
      _1399: (a, i) => a.splice(i, 1),
      _1400: (a, s) => a.join(s),
      _1401: (a, s, e) => a.slice(s, e),
      _1404: a => a.length,
      _1406: (a, i) => a[i],
      _1407: (a, i, v) => a[i] = v,
      _1409: o => {
        if (o instanceof ArrayBuffer) return 0;
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
          return 1;
        }
        return 2;
      },
      _1410: (o, offsetInBytes, lengthInBytes) => {
        var dst = new ArrayBuffer(lengthInBytes);
        new Uint8Array(dst).set(new Uint8Array(o, offsetInBytes, lengthInBytes));
        return new DataView(dst);
      },
      _1412: o => o instanceof Uint8Array,
      _1413: (o, start, length) => new Uint8Array(o.buffer, o.byteOffset + start, length),
      _1414: o => o instanceof Int8Array,
      _1415: (o, start, length) => new Int8Array(o.buffer, o.byteOffset + start, length),
      _1416: o => o instanceof Uint8ClampedArray,
      _1417: (o, start, length) => new Uint8ClampedArray(o.buffer, o.byteOffset + start, length),
      _1418: o => o instanceof Uint16Array,
      _1419: (o, start, length) => new Uint16Array(o.buffer, o.byteOffset + start, length),
      _1420: o => o instanceof Int16Array,
      _1421: (o, start, length) => new Int16Array(o.buffer, o.byteOffset + start, length),
      _1422: o => o instanceof Uint32Array,
      _1423: (o, start, length) => new Uint32Array(o.buffer, o.byteOffset + start, length),
      _1424: o => o instanceof Int32Array,
      _1425: (o, start, length) => new Int32Array(o.buffer, o.byteOffset + start, length),
      _1427: (o, start, length) => new BigInt64Array(o.buffer, o.byteOffset + start, length),
      _1428: o => o instanceof Float32Array,
      _1429: (o, start, length) => new Float32Array(o.buffer, o.byteOffset + start, length),
      _1430: o => o instanceof Float64Array,
      _1431: (o, start, length) => new Float64Array(o.buffer, o.byteOffset + start, length),
      _1432: (t, s) => t.set(s),
      _1434: (o) => new DataView(o.buffer, o.byteOffset, o.byteLength),
      _1436: o => o.buffer,
      _1437: o => o.byteOffset,
      _1438: Function.prototype.call.bind(Object.getOwnPropertyDescriptor(DataView.prototype, 'byteLength').get),
      _1439: (b, o) => new DataView(b, o),
      _1440: (b, o, l) => new DataView(b, o, l),
      _1441: Function.prototype.call.bind(DataView.prototype.getUint8),
      _1442: Function.prototype.call.bind(DataView.prototype.setUint8),
      _1443: Function.prototype.call.bind(DataView.prototype.getInt8),
      _1444: Function.prototype.call.bind(DataView.prototype.setInt8),
      _1445: Function.prototype.call.bind(DataView.prototype.getUint16),
      _1446: Function.prototype.call.bind(DataView.prototype.setUint16),
      _1447: Function.prototype.call.bind(DataView.prototype.getInt16),
      _1448: Function.prototype.call.bind(DataView.prototype.setInt16),
      _1449: Function.prototype.call.bind(DataView.prototype.getUint32),
      _1450: Function.prototype.call.bind(DataView.prototype.setUint32),
      _1451: Function.prototype.call.bind(DataView.prototype.getInt32),
      _1452: Function.prototype.call.bind(DataView.prototype.setInt32),
      _1455: Function.prototype.call.bind(DataView.prototype.getBigInt64),
      _1456: Function.prototype.call.bind(DataView.prototype.setBigInt64),
      _1457: Function.prototype.call.bind(DataView.prototype.getFloat32),
      _1458: Function.prototype.call.bind(DataView.prototype.setFloat32),
      _1459: Function.prototype.call.bind(DataView.prototype.getFloat64),
      _1460: Function.prototype.call.bind(DataView.prototype.setFloat64),
      _1473: (ms, c) =>
      setTimeout(() => dartInstance.exports.$invokeCallback(c),ms),
      _1474: (handle) => clearTimeout(handle),
      _1475: (ms, c) =>
      setInterval(() => dartInstance.exports.$invokeCallback(c), ms),
      _1476: (handle) => clearInterval(handle),
      _1477: (c) =>
      queueMicrotask(() => dartInstance.exports.$invokeCallback(c)),
      _1478: () => Date.now(),
      _1483: o => Object.keys(o),
      _1484: () => new AbortController(),
      _1485: x0 => x0.abort(),
      _1486: (x0,x1,x2,x3,x4,x5) => ({method: x0,headers: x1,body: x2,credentials: x3,redirect: x4,signal: x5}),
      _1487: (x0,x1) => globalThis.fetch(x0,x1),
      _1488: (x0,x1) => x0.get(x1),
      _1489: f => finalizeWrapper(f, function(x0,x1,x2) { return dartInstance.exports._1489(f,arguments.length,x0,x1,x2) }),
      _1490: (x0,x1) => x0.forEach(x1),
      _1491: x0 => x0.getReader(),
      _1492: x0 => x0.read(),
      _1493: x0 => x0.cancel(),
      _1520: (s, m) => {
        try {
          return new RegExp(s, m);
        } catch (e) {
          return String(e);
        }
      },
      _1521: (x0,x1) => x0.exec(x1),
      _1522: (x0,x1) => x0.test(x1),
      _1523: x0 => x0.pop(),
      _1525: o => o === undefined,
      _1527: o => typeof o === 'function' && o[jsWrappedDartFunctionSymbol] === true,
      _1529: o => {
        const proto = Object.getPrototypeOf(o);
        return proto === Object.prototype || proto === null;
      },
      _1530: o => o instanceof RegExp,
      _1531: (l, r) => l === r,
      _1532: o => o,
      _1533: o => o,
      _1534: o => o,
      _1535: b => !!b,
      _1536: o => o.length,
      _1538: (o, i) => o[i],
      _1539: f => f.dartFunction,
      _1540: () => ({}),
      _1541: () => [],
      _1543: () => globalThis,
      _1544: (constructor, args) => {
        const factoryFunction = constructor.bind.apply(
            constructor, [null, ...args]);
        return new factoryFunction();
      },
      _1546: (o, p) => o[p],
      _1547: (o, p, v) => o[p] = v,
      _1548: (o, m, a) => o[m].apply(o, a),
      _1550: o => String(o),
      _1551: (p, s, f) => p.then(s, (e) => f(e, e === undefined)),
      _1552: o => {
        if (o === undefined) return 1;
        var type = typeof o;
        if (type === 'boolean') return 2;
        if (type === 'number') return 3;
        if (type === 'string') return 4;
        if (o instanceof Array) return 5;
        if (ArrayBuffer.isView(o)) {
          if (o instanceof Int8Array) return 6;
          if (o instanceof Uint8Array) return 7;
          if (o instanceof Uint8ClampedArray) return 8;
          if (o instanceof Int16Array) return 9;
          if (o instanceof Uint16Array) return 10;
          if (o instanceof Int32Array) return 11;
          if (o instanceof Uint32Array) return 12;
          if (o instanceof Float32Array) return 13;
          if (o instanceof Float64Array) return 14;
          if (o instanceof DataView) return 15;
        }
        if (o instanceof ArrayBuffer) return 16;
        // Feature check for `SharedArrayBuffer` before doing a type-check.
        if (globalThis.SharedArrayBuffer !== undefined &&
            o instanceof SharedArrayBuffer) {
            return 17;
        }
        return 18;
      },
      _1553: o => [o],
      _1554: (o0, o1) => [o0, o1],
      _1555: (o0, o1, o2) => [o0, o1, o2],
      _1556: (o0, o1, o2, o3) => [o0, o1, o2, o3],
      _1557: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI8ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1558: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI8ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1561: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmI32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1562: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmI32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1563: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF32ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1564: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF32ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1565: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const getValue = dartInstance.exports.$wasmF64ArrayGet;
        for (let i = 0; i < length; i++) {
          jsArray[jsArrayOffset + i] = getValue(wasmArray, wasmArrayOffset + i);
        }
      },
      _1566: (jsArray, jsArrayOffset, wasmArray, wasmArrayOffset, length) => {
        const setValue = dartInstance.exports.$wasmF64ArraySet;
        for (let i = 0; i < length; i++) {
          setValue(wasmArray, wasmArrayOffset + i, jsArray[jsArrayOffset + i]);
        }
      },
      _1567: x0 => new ArrayBuffer(x0),
      _1568: s => {
        if (/[[\]{}()*+?.\\^$|]/.test(s)) {
            s = s.replace(/[[\]{}()*+?.\\^$|]/g, '\\$&');
        }
        return s;
      },
      _1570: x0 => x0.index,
      _1572: x0 => x0.flags,
      _1573: x0 => x0.multiline,
      _1574: x0 => x0.ignoreCase,
      _1575: x0 => x0.unicode,
      _1576: x0 => x0.dotAll,
      _1577: (x0,x1) => { x0.lastIndex = x1 },
      _1578: (o, p) => p in o,
      _1579: (o, p) => o[p],
      _1582: x0 => x0.random(),
      _1585: () => globalThis.Math,
      _1586: Function.prototype.call.bind(Number.prototype.toString),
      _1587: Function.prototype.call.bind(BigInt.prototype.toString),
      _1588: Function.prototype.call.bind(Number.prototype.toString),
      _1589: (d, digits) => d.toFixed(digits),
      _3468: () => globalThis.window,
      _3530: x0 => x0.navigator,
      _3919: x0 => x0.userAgent,
      _6074: x0 => x0.signal,
      _7910: x0 => x0.value,
      _7912: x0 => x0.done,
      _8614: x0 => x0.url,
      _8616: x0 => x0.status,
      _8618: x0 => x0.statusText,
      _8619: x0 => x0.headers,
      _8620: x0 => x0.body,
      _12248: x0 => x0.name,

    };

    const baseImports = {
      dart2wasm: dart2wasm,
      Math: Math,
      Date: Date,
      Object: Object,
      Array: Array,
      Reflect: Reflect,
      S: new Proxy({}, { get(_, prop) { return prop; } }),

    };

    const jsStringPolyfill = {
      "charCodeAt": (s, i) => s.charCodeAt(i),
      "compare": (s1, s2) => {
        if (s1 < s2) return -1;
        if (s1 > s2) return 1;
        return 0;
      },
      "concat": (s1, s2) => s1 + s2,
      "equals": (s1, s2) => s1 === s2,
      "fromCharCode": (i) => String.fromCharCode(i),
      "length": (s) => s.length,
      "substring": (s, a, b) => s.substring(a, b),
      "fromCharCodeArray": (a, start, end) => {
        if (end <= start) return '';

        const read = dartInstance.exports.$wasmI16ArrayGet;
        let result = '';
        let index = start;
        const chunkLength = Math.min(end - index, 500);
        let array = new Array(chunkLength);
        while (index < end) {
          const newChunkLength = Math.min(end - index, 500);
          for (let i = 0; i < newChunkLength; i++) {
            array[i] = read(a, index++);
          }
          if (newChunkLength < chunkLength) {
            array = array.slice(0, newChunkLength);
          }
          result += String.fromCharCode(...array);
        }
        return result;
      },
      "intoCharCodeArray": (s, a, start) => {
        if (s === '') return 0;

        const write = dartInstance.exports.$wasmI16ArraySet;
        for (var i = 0; i < s.length; ++i) {
          write(a, start++, s.charCodeAt(i));
        }
        return s.length;
      },
      "test": (s) => typeof s == "string",
    };


    

    dartInstance = await WebAssembly.instantiate(this.module, {
      ...baseImports,
      ...additionalImports,
      
      "wasm:js-string": jsStringPolyfill,
    });

    return new InstantiatedApp(this, dartInstance);
  }
}

class InstantiatedApp {
  constructor(compiledApp, instantiatedModule) {
    this.compiledApp = compiledApp;
    this.instantiatedModule = instantiatedModule;
  }

  // Call the main function with the given arguments.
  invokeMain(...args) {
    this.instantiatedModule.exports.$invokeMain(args);
  }
}

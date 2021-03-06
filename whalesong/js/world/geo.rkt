#lang s-exp "../../lang/base.rkt"

(require "../../js.rkt")
(require "../../js/world.rkt")

(provide on-geo)

(define setup-geo
  (js-function->procedure
   "function(locationCallback) {
        return navigator.geolocation.watchPosition(
            function(evt) {
                var coords = evt.coords;
                locationCallback(plt.runtime.makeFloat(coords.latitude),
                                 plt.runtime.makeFloat(coords.longitude)); })}"))

(define shutdown-geo
  (js-function->procedure
   "function(watchId) {
        navigator.geolocation.clearWatch(watchId); }"))


;; A new event handler type for geolocation:
;;
;; Use it as any other world handler:
;;
;; (big-bang ...
;;           [on-geo (lambda (world view lat lng)
;;                     ...)]
;;
;;           ...)
(define on-geo (make-world-event-handler setup-geo shutdown-geo))


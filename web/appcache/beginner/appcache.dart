// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This is a port of "A Beginner's Guide to Using the Application Cache" to
// Dart. See: http://www.html5rocks.com/en/tutorials/appcache/beginner

import 'dart:html';

class AppCache {
  DOMApplicationCache appCache;

  AppCache(this.appCache) {
    // Set up handlers to log all of the cache events or errors.
    appCache.on.cached.add(onCacheEvent);
    appCache.on.checking.add(onCacheEvent);
    appCache.on.downloading.add(onCacheEvent);
    appCache.on.error.add(onCacheError);
    appCache.on.noUpdate.add(onCacheEvent);
    appCache.on.obsolete.add(onCacheEvent);
    appCache.on.progress.add(onCacheEvent);

    // Set up a more interesting handler to swap in the new app when ready.
    appCache.on.updateReady.add((e) => updateReady());
  }

  void updateReady() {
    if (appCache.status == DOMApplicationCache.UPDATEREADY) {
      // The browser downloaded a new app cache. Alert the user and swap it in
      // to get the new hotness.
      appCache.swapCache();

      // TODO(jason9t): window.location.reload() is blocked by this bug:
      // https://code.google.com/p/dart/issues/detail?id=5551
      // So for now we'll just advise the user to refresh manually.
      // if (window.confirm('A new version of this site is available. Reload?')) {
      //   window.location.reload();
      // }
      window.alert('A new version of this site is available. Please reload.');
    }
  }

  void onCacheEvent(Event e) {
    print('Cache event: ${e}');
  }

  void onCacheError(Event e) {
    // For the sake of this sample alert the reader that an error has occurred.
    // Of course we would *never* do it this way in real life.
    window.alert("Oh no! A cache error occurred: ${e}");
    print('Cache error: ${e}');
  }
}

void main() {
  new AppCache(window.applicationCache);
}

'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "fd002819aef023c63f745e8dbb999e26",
"assets/AssetManifest.bin.json": "ab58e960d45dcba22744b00b045bf405",
"assets/AssetManifest.json": "a53cd3ba7824aa4b28692bb562def5cf",
"assets/assets/fonts/syncopate-cyr.otf": "1b792500f7a787a36774e924a63092f0",
"assets/cards/adders/Mansarda.png": "d3ceaadfbb003c75a9b7f3f7fd873cd3",
"assets/cards/adders/MiM.png": "e2fe44144f463e94c6a32b975a1bf7a7",
"assets/cards/adders/SVP.png": "b14bbc00f1523d95b096dc1f23fcddc4",
"assets/cards/adders/TSh.png": "1e3bb09d4019dd846d46fa2a1e57719c",
"assets/cards/damaggers/Chizhova.png": "48853ff26eae0c0ba6216410eb089977",
"assets/cards/damaggers/Evstafeva.png": "bed7fc42955ffdb96ffcf13f5fbe8ece",
"assets/cards/damaggers/Fefelova.png": "75c0e75e810309dc62c9db2171c37089",
"assets/cards/damaggers/Koltsov.png": "e5fd8d2ca26e340cdb122bc38934f441",
"assets/cards/damaggers/Levkin.png": "b9a7f2cb4110c9e43fef74d3c201eb69",
"assets/cards/damaggers/Sirina.png": "a300da46a6db1c7ba0489f6d9164a4f3",
"assets/cards/damaggers/Son.png": "9563c0e45ad27bd491b7e115977a64bd",
"assets/cards/healers/Badmaev.png": "6a27392373921fc29118576b57116e4e",
"assets/cards/healers/Ledovskih.png": "e1bc8739fd29713f54d91df366678793",
"assets/cards/healers/Permyakova.png": "9229ab26dc2325dae1a55e386e23031e",
"assets/cards/healers/Ryabov.png": "ee7f845151fca46fa09a54c02ac05f62",
"assets/cards/healers/Sharipova.png": "69881c7619cafdb07e5f4e7482541cf8",
"assets/cards/healers/Shevnyakov.png": "77723e6dedcbd745e47677d624c0c584",
"assets/cards/healers/Zvezdakov.png": "9463ad3ea0d11d8ad0a1dc47ce7e9d4f",
"assets/cards/shielders/Agafonov.png": "9d426c690e72b9eeaf0c1615b7afdd62",
"assets/cards/shielders/Arhipenkov.png": "0b921c263197bd19ccb21223581bef69",
"assets/cards/shielders/Drofichev.png": "ac62d7a948a03b2b0618fd45f0c53435",
"assets/cards/shielders/Fedorov.png": "bfd5062eed81b0d988d06bf57a93fb3a",
"assets/cards/shielders/Gorbunov.png": "6a65be74791dd9b5b90220ac6715709d",
"assets/cards/shielders/Kucher.png": "c8f25d18af7f14ec3f3b90842ad543ba",
"assets/cards/shielders/Vorobyev.png": "3a0f7c2e7dc801ba202b778013e9a86b",
"assets/cards/supports/Aksenov.png": "a2455803f1f6390532cbd15ce8d7f67a",
"assets/cards/supports/Lahta.png": "f55a35653cebc51c2f9fcd0e1e799ad7",
"assets/cards/supports/Leluh.png": "ae37d0ad8d3c6344a3aaed7eca024857",
"assets/cards/supports/Lopatkova.png": "e8c17dda64aaf3cfe3b76ee07523de3b",
"assets/cards/supports/Nikolaeva.png": "af550b586890fea5ed3ecaef1dadc60c",
"assets/cards/supports/Pligun.png": "1ee3e8c315209561de227ca440bf814a",
"assets/cards/supports/Troshin.png": "0c0f6259555500b54814fdccf6af0e41",
"assets/FontManifest.json": "403695aa729a3b6d311feeecbb5d7393",
"assets/fonts/MaterialIcons-Regular.otf": "baacdbfcd62b49cd389c9a8d7c176c58",
"assets/images/abaddonedCards/abaddonedCard1.png": "959f7179979df81c692e46e497e634d3",
"assets/images/abaddonedCards/abaddonedCard2.png": "c11d7b38841aa314ec83f66ccc7a67ae",
"assets/images/abaddonedCards/abaddonedCard3.png": "a6c70763252810ea3021d9cb82c1ba38",
"assets/images/abaddonedCards/abaddonedCard4.png": "9e48ede699cc20608ca29e0f09906c12",
"assets/images/backgroundZ.svg": "148d7a4be6716e5b081bb3f939f68ffb",
"assets/images/HP.svg": "406a5dd69b3e759a899be8632fc0ceba",
"assets/images/icoClock.svg": "45fb9eb7ce801ba5a2f2540d83fdbd7f",
"assets/images/icoDamagger.svg": "cc290aca9c1618eb1ea5e878c23e4654",
"assets/images/icoHealer.svg": "3872b8f8f5356781c24665cc2c59c7ff",
"assets/images/icoShielder.svg": "25581d4ab8bba954b9d1db9d7a4e76d3",
"assets/images/icoSupport.svg": "d11857cdae8e11d7741284115f38a180",
"assets/images/lightning.svg": "2018386a91021f9cd34da2d5e70c80fe",
"assets/images/logo.svg": "aa2a30e8cd71b61c120e866c4365f0c0",
"assets/images/missing_avatar.jpg": "e4f8640c7dfb8e66f06804dd6bdd5b12",
"assets/images/missing_avatar1.jpg": "7760276540837102078c11a830b840e9",
"assets/NOTICES": "87ee3f8aea85bfb4ab5ee544954f79de",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/rules/page_1.png": "7fe571fb83dbcfbea1f243c484bf22e2",
"assets/rules/page_10.png": "50177bcaedcd4edc4532fda0665672d5",
"assets/rules/page_11.png": "e3835bac2976f8109fa3432348ff097a",
"assets/rules/page_12.png": "0cfda3169ac9117f30a079ae35fcdbe9",
"assets/rules/page_13.png": "f14155cd132f9656b5ef20a32b6492bd",
"assets/rules/page_14.png": "eeb062f2321d742c0056688eec7583dc",
"assets/rules/page_15.png": "af17f1f3794849579573e1755ba362d9",
"assets/rules/page_16.png": "3bc5da3a8122c3a936d5106273c8b267",
"assets/rules/page_17.png": "14dafe253b4aed44843ad39e91c17139",
"assets/rules/page_18.png": "0d536d40e690889a6d2ecb9ec12ff496",
"assets/rules/page_19.png": "c2a1e448e8bc6dce977952ac90f96113",
"assets/rules/page_2.png": "540e24163de708f676a5879dcf942182",
"assets/rules/page_20.png": "c928c2ad09d41018aa541dbc0c8af2c8",
"assets/rules/page_21.png": "1280abb7e0730e880dd4c86cb027d2d8",
"assets/rules/page_22.png": "4e0e619a526ef46427d6f321a6fcaf2d",
"assets/rules/page_23.png": "d59a2225e278e06543662117a2a93bd8",
"assets/rules/page_24.png": "9473a583b20747308718776f6d7953dd",
"assets/rules/page_25.png": "dff1af59189f537333fe68da1ce310db",
"assets/rules/page_26.png": "88eece2e133758f146d650cbf067933a",
"assets/rules/page_27.png": "1905c96900615c339909da97fad607e6",
"assets/rules/page_28.png": "e3c3f07ae7d9cb6f61a17811be999d5c",
"assets/rules/page_29.png": "b29234a030bb6194aee5196b25313a20",
"assets/rules/page_3.png": "4f69a1c10039b79b69bbca28349db295",
"assets/rules/page_30.png": "5c56bb3377ca8b2f2ed1dec4ae809797",
"assets/rules/page_31.png": "1662d6eb5765f26479bddc2fd7828af9",
"assets/rules/page_32.png": "05d30d123ddc245e980ab3894e907933",
"assets/rules/page_33.png": "f30778f1929e2a29db5f89f3c98080a8",
"assets/rules/page_34.png": "0b1569da35d50d9ed7020be718bc9988",
"assets/rules/page_35.png": "83e078282ee76e78ea1c0bd48827198c",
"assets/rules/page_36.png": "57e89268db209e1e0b4c96ebe9e1af4e",
"assets/rules/page_37.png": "100220942058546343652fe04806ec7d",
"assets/rules/page_38.png": "f820041f21cf50732ba637d878cd26d9",
"assets/rules/page_39.png": "e872e4cefff32135a948a4847b496139",
"assets/rules/page_4.png": "0c5797ec0ba0417be66ea2301f7670c9",
"assets/rules/page_40.png": "f8fd8fb5fc9adbc6f998810d564d0dc8",
"assets/rules/page_41.png": "566a429eb0ce45b422e5d1252c4f1ae8",
"assets/rules/page_42.png": "40219e35a1632e40bb907b7588d41b4b",
"assets/rules/page_43.png": "50a47d5b336219ff92e147a3806e2901",
"assets/rules/page_44.png": "ceff68441e30c5c3d73c2a5c6cdd7d47",
"assets/rules/page_45.png": "887cca4a43fa7a3ac15c8bb54498f392",
"assets/rules/page_46.png": "422b8d0dde1df866f985a7dd0676fe73",
"assets/rules/page_47.png": "9204cd6a75d52fa001295583d937a1a6",
"assets/rules/page_48.png": "83ed9f5b84f0d793967c1bb2d8325e3c",
"assets/rules/page_5.png": "95cdfb70dba81b7b2a5a313590fc62cb",
"assets/rules/page_6.png": "ab4f94e4a44e6c5600f2539b0d84d131",
"assets/rules/page_7.png": "9b74d58d628c0e232d0f1f1fa7b655bb",
"assets/rules/page_8.png": "0fa329203ced459344f84df7380f8c8c",
"assets/rules/page_9.png": "78c428ac53645784d6c5420a2ddebe10",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "2e31d21a9684e030f683924ed7a63ac9",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b275eefe54ea86afa8fab4b784d6fff5",
"/": "b275eefe54ea86afa8fab4b784d6fff5",
"main.dart.js": "f61dfdaf9afb18a2a65dc4b63c36bb80",
"manifest.json": "bf24c84c3bf99672a631c4f84464e793",
"version.json": "055f843b12128a5968457aec52406524"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

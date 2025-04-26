'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "2001bbafb937de15a11637433bfa9d4a",
"version.json": "46e60ef4b07f0ed4407733571edaa2a1",
"index.html": "7ba5a661898d98c362f0dd43e14133a1",
"/": "7ba5a661898d98c362f0dd43e14133a1",
"main.dart.js": "b55bb8ace1d36fd8fb479bf1fda1ce24",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "b65015a16e9c808281b975fb961ce659",
"assets/AssetManifest.json": "4a64dfab9f25b088b02e832b4bb52f23",
"assets/NOTICES": "ca28fcfaf7b67671dbff9d2531aa3cec",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "e830b4f9e9abaa7dd8f6ce0997cf23fc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "12b901a8f8b2f71369198d60f816cef8",
"assets/packages/map_launcher/assets/icons/mappls.svg": "1a75722e15a1700115955325fe34502b",
"assets/packages/map_launcher/assets/icons/citymapper.svg": "58c49ff6df286e325c21a28ebf783ebe",
"assets/packages/map_launcher/assets/icons/sygicTruck.svg": "242728853b652fa765de8fba7ecd250f",
"assets/packages/map_launcher/assets/icons/naver.svg": "ef3ef5881d4a2beb187dfc87e23b6133",
"assets/packages/map_launcher/assets/icons/tencent.svg": "4e1babec6bbab0159bdc204932193a89",
"assets/packages/map_launcher/assets/icons/copilot.svg": "b412a5f02e8cef01cdb684b03834cc03",
"assets/packages/map_launcher/assets/icons/truckmeister.svg": "416d2d7d2be53cd772bc59b910082a5b",
"assets/packages/map_launcher/assets/icons/yandexNavi.svg": "bad6bf6aebd1e0d711f3c7ed9497e9a3",
"assets/packages/map_launcher/assets/icons/yandexMaps.svg": "3dfd1d365352408e86c9c57fef238eed",
"assets/packages/map_launcher/assets/icons/tmap.svg": "50c98b143eb16f802a756294ed04b200",
"assets/packages/map_launcher/assets/icons/petal.svg": "76c9cfa1bfefb298416cfef6a13a70c5",
"assets/packages/map_launcher/assets/icons/doubleGis.svg": "ab8f52395c01fcd87ed3e2ed9660966e",
"assets/packages/map_launcher/assets/icons/here.svg": "aea2492cde15953de7bb2ab1487fd4c7",
"assets/packages/map_launcher/assets/icons/tomtomgofleet.svg": "5b12dcb09ec0a67934e6586da67a0149",
"assets/packages/map_launcher/assets/icons/mapswithme.svg": "87df7956e58cae949e88a0c744ca49e8",
"assets/packages/map_launcher/assets/icons/osmandplus.svg": "31c36b1f20dc45a88c283e928583736f",
"assets/packages/map_launcher/assets/icons/google.svg": "cb318c1fc31719ceda4073d8ca38fc1e",
"assets/packages/map_launcher/assets/icons/googleGo.svg": "cb318c1fc31719ceda4073d8ca38fc1e",
"assets/packages/map_launcher/assets/icons/mapyCz.svg": "f5a198b01f222b1201e826495661008c",
"assets/packages/map_launcher/assets/icons/kakao.svg": "1c7c75914d64033825ffc0ff2bdbbb58",
"assets/packages/map_launcher/assets/icons/osmand.svg": "639b2304776a6794ec682a926dbcbc4c",
"assets/packages/map_launcher/assets/icons/tomtomgo.svg": "493b0844a3218a19b1c80c92c060bba7",
"assets/packages/map_launcher/assets/icons/flitsmeister.svg": "44ba265e6077dd5bf98668dc2b8baec1",
"assets/packages/map_launcher/assets/icons/baidu.svg": "22335d62432f9d5aac833bcccfa5cfe8",
"assets/packages/map_launcher/assets/icons/apple.svg": "6fe49a5ae50a4c603897f6f54dec16a8",
"assets/packages/map_launcher/assets/icons/waze.svg": "311a17de2a40c8fa1dd9022d4e12982c",
"assets/packages/map_launcher/assets/icons/amap.svg": "00409535b144c70322cd4600de82657c",
"assets/packages/flutter_rating_stars/assets/star_off.png": "510ce4aac7c14568132bdda920c8a76e",
"assets/packages/wakelock_plus/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6788c7887c44bf7a1a028c56998ad294",
"assets/fonts/MaterialIcons-Regular.otf": "88e9c192a156bd47c164a96a11940b6c",
"assets/assets/tflite/labels.txt": "dc15e2d113af205675706e09ed046b8c",
"assets/assets/tflite/model_unquant.tflite": "2e6d0fae8f5e1b01065e912bb6309c46",
"assets/assets/images/ranking.png": "fa05c7c127442903328d5ab397a7947a",
"assets/assets/images/image_intro_3.png": "9c4d8b7b26948f0a8ff706174d506c2e",
"assets/assets/images/image_intro_2.png": "1bebdde14db3e78051f213d109f70ea0",
"assets/assets/images/loading.json": "2a7bcaa2c064077cbdca0dc28916887c",
"assets/assets/images/image_intro_1.png": "dabff1750f5a39e93771f5bb6a80b71c",
"assets/assets/images/succesfull.json": "d851f164c5de374640f572ce6812a6d0",
"assets/assets/images/male.png": "4b8332b226304129ea2a5415d80bef27",
"assets/assets/images/avt.png": "960d9c1c928cebe61055dc3b0bcab8a3",
"assets/assets/images/demo_360.jpg": "282e82365379a968199397058768ba51",
"assets/assets/images/background_appbar.png": "b1175a64371093c932965339cb89e0a7",
"assets/assets/images/female.png": "ebdb5795ad2c97206993806be152249d",
"assets/assets/images/banner_ranking.png": "f36304875a3436e4d25f5c14ae2a2cf2",
"assets/assets/images/logo.png": "d55be190eb594e2fa6cc8fb3b06e60ca",
"assets/assets/images/blur_intro.png": "514e2b5c086f0d141856c1a2e943f362",
"assets/assets/images/background_option.jpg": "d9106b61967ca247d8c91a43f20c9e65",
"assets/assets/images/intro_01.jpg": "d371eda01c1200a77b798a0018cbaf29",
"assets/assets/images/panorama1.webp": "263e876b53a88208a4b9022336d8b635",
"assets/assets/images/empty_booking.png": "5460ed9936778701f276e34a3479757b",
"assets/assets/images/message_loading.json": "cb6aa7766056d8c9cd2d2fcc17dcc079",
"assets/assets/images/spash_background.jpg": "f1c9d4b003c20884804b0d890749ac61",
"assets/assets/images/logo_color.png": "218a7353c385d56a5962887001d39696",
"assets/assets/icons/ic_phone.svg": "1bc8de6cad784252640fb026874d546b",
"assets/assets/icons/ic_clock.svg": "5630b442f5938ca827e49913f573fbfc",
"assets/assets/icons/ic_favorite.svg": "fe8c98611f9a572528b3d9532d563198",
"assets/assets/icons/ic_filter.svg": "7069892d99ffe602fc3d2ae40fa3e093",
"assets/assets/icons/ic_share.svg": "48bf6711c6b35a861fcaefa0dcd06da3",
"assets/assets/icons/ic_arrow_right_double.svg": "6e80a90d3c85f8b8462ed02edef2dea9",
"assets/assets/icons/ic_comment.svg": "e61c0ef7d41f71ec55ce8f76e77b5085",
"assets/assets/icons/ic_pin_location.svg": "0b2f9f5a32ab162b92f67183cba7ee2e",
"assets/assets/icons/ic_notification_pink.svg": "55371a860df803ffa884dc29a16957a9",
"assets/assets/icons/ic_messager.svg": "6b5763ded66c624c54bca65d9e4d0df2",
"assets/assets/icons/ic_sms.svg": "ee76571380a4c31fda12f83a253d55d4",
"assets/assets/icons/ic_money.svg": "af915230a84314df60f925625398b507",
"assets/assets/icons/ic_history_activity.svg": "c7734a146c4d7e3026386f6a3ab95941",
"assets/assets/icons/ic_facebook.svg": "5216ff05e6eecd1c5942e67f0e3e05fb",
"assets/assets/icons/ic_like_active.svg": "9cabab0b125a4cd55f143d9d25bcb4a2",
"assets/assets/icons/ic_booking_appoinment.svg": "7669b1e5a9785a22d9aebb551b363179",
"assets/assets/icons/logo_app.png": "ad6b5b874b19cf37a33e3eb04092cfd4",
"assets/assets/icons/ic_lock.svg": "4b4a29b8ca0ec3c97d1950a573eccb44",
"assets/assets/icons/ic_post.svg": "1f13f77916083c278ee92fc550a4df5e",
"assets/assets/icons/ic_success.svg": "d29f1779664178a55ed87236fd97c302",
"assets/assets/icons/ic_zalo.svg": "19c25b1f48ae118533fca2a65d160e5b",
"assets/assets/icons/ic_news.svg": "e8d6b19edbfd205e7d7bbdbb7677217f",
"assets/assets/icons/ic_error.svg": "b2138751ec3c40bb5c24fcea41aaff9d",
"assets/assets/icons/ic_other.svg": "2ed785734e3b2cf6e2cb49872af1fadd",
"assets/assets/icons/ic_whatsapp.svg": "2f545230b4df05d376f29a6ecdafe608",
"assets/assets/icons/ic_apple.svg": "7f2e10f6a7ab79b1a3457479737aa9ab",
"assets/assets/icons/ic_version.svg": "9da8e1a3230eb93a06eba32eafcc0f41",
"assets/assets/icons/ic_home.svg": "4c424f3256543ba3639858faa46db810",
"assets/assets/icons/ic_camera.svg": "11f75aa6da3496e88d92d6d1bd672fbc",
"assets/assets/icons/ic_no_data.svg": "51283218f20bab6dd2bde639d2d7fa46",
"assets/assets/icons/ic_check_circle.svg": "d058a586a948721dd1f77b90d15a0452",
"assets/assets/icons/ic_add_booking.svg": "5186d5a7bbb019f030cac14cc5fc67a3",
"assets/assets/icons/ic_language.svg": "f89c2068930aca527e7e5bc89d7bca38",
"assets/assets/icons/ic_setting.svg": "3046768e94d764b7e50e46d9f9680e51",
"assets/assets/icons/ic_report.svg": "1f5afd537030a93b795b66bc96587834",
"assets/assets/icons/ic_delete_account.svg": "a4f6b9e89ee93151c637814c6bd36d4e",
"assets/assets/icons/ic_store_active.svg": "3f299516f339ee9ca45dee4ed9373a19",
"assets/assets/icons/ic_message.svg": "1574e6f128428c259dcd7382a784389a",
"assets/assets/icons/ic_marker.svg": "d022dfac1068d5aa63a905ca9713d40f",
"assets/assets/icons/ic_list.svg": "d7118ef66b83e00f6ee5a3231499cb8d",
"assets/assets/icons/ic_notification.svg": "26852219d33c4a7f8ac2d2359ccfbd01",
"assets/assets/icons/ic_like.svg": "9ae4419cf116e62a8c3616b6c5b59201",
"assets/assets/icons/ic_calendar.svg": "c361e8bf1c17fbe42246e0d5ce1df1e5",
"assets/assets/icons/ic_open_eye.svg": "9b42f83ad6accc417e4d4748ce034ff0",
"assets/assets/icons/ic_arrow_left.svg": "3052d436b1c1345f520f623145bd67df",
"assets/assets/icons/ic_home_active.svg": "abd22f2bc705fa57e9aa10176ba34d11",
"assets/assets/icons/ic_arrow_right.svg": "f0b66685aa903af850bd3003c5efc2b2",
"assets/assets/icons/ic_map.svg": "7314b5311752adc87df00376fa3fa65f",
"assets/assets/icons/ic_google.svg": "147b40689cb2cd7acc1ceb85e96513e3",
"assets/assets/icons/ic_vr_nail_active.svg": "78cf2a1f77eb92848d89cabaf23385a2",
"assets/assets/icons/ic_store.svg": "65d834c3a5b70452b387f979030d0700",
"assets/assets/icons/ic_favorite_outline.svg": "c34bd27c5ea8c8e60ff793aa845fc41d",
"assets/assets/icons/ic_my_location.svg": "9145a40b69df0644b15f75f5485beb4b",
"assets/assets/icons/ic_nail.svg": "7a011eb9975eaa58f68e1cd3ec91121c",
"assets/assets/icons/ic_vi.svg": "497b404b0475acb14a53c65a7435d706",
"assets/assets/icons/ic_privacity.svg": "edfef41bb23e3f0ceb79d7b7718d7772",
"assets/assets/icons/ic_close_eye.svg": "b8061775b8f6eb2802b5bcde03f98798",
"assets/assets/icons/ic_warning.svg": "35659b9c290f5abab33a28bf40a80d3f",
"assets/assets/icons/ic_menu.svg": "7d389c55de681a05b8b8a1c25f2ef1a2",
"assets/assets/icons/ic_email.svg": "d2d10d9084f9ffe118d96fd98d9554f1",
"assets/assets/icons/ic_logout_pink.svg": "19e53b9feb39065994eba35d23a78490",
"assets/assets/icons/ic_account.svg": "0cf9bfda709582ec1b48f04515498d9a",
"assets/assets/icons/ic_chat.svg": "488c9dfb080bfe9c230e1448e0ab7f64",
"assets/assets/icons/ic_post_active.svg": "df917d8fdbd87def262de4b63665353d",
"assets/assets/icons/ic_en.svg": "bf66bf68a5a31afcef5441cee85bd16e",
"assets/assets/icons/ic_search.svg": "4d2aaa74c15e39b4f839e9316bc8ed97",
"assets/assets/icons/ic_telegram.svg": "b20defbc7bced3a35a6af5b64f6cf275",
"assets/assets/icons/ic_address.svg": "5280e73d698ea293206815ba683ac0c6",
"assets/assets/icons/ic_change_password.svg": "29246b6f6d177bbdb4568d5664a4c697",
"assets/assets/icons/ic_edit.svg": "da1da637588a9c01fd55c72e4ddfee10",
"assets/assets/icons/ic_star.svg": "ed226aab6f704127ef405aec046cb6ad",
"assets/assets/icons/ic_pass_incorrect.svg": "84ea3cd50028fa892c01a21ff4754d92",
"assets/assets/icons/ic_vr_nail.svg": "550f591e813714c2a56a516efa1441c0",
"assets/assets/icons/ic_logout.svg": "a5f766e3563481836b62b2c25c72ec28",
"assets/assets/icons/ic_check_circle_active.svg": "0f36f974e46f2a36ca654c380dc3ed63",
"assets/assets/icons/ic_instagram.svg": "ffc710e11078588f9daaa76844b196d4",
"assets/assets/sql/init_db_local.sql": "5255b76e830e1e557c799685267ae5e1",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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

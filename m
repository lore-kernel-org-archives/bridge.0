Date: Wed, 2 Feb 2005 19:24:08 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Message-ID: <Pine.LNX.4.62.0502021921100.19651@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1751054372-1107390248=:19651"
Subject: [Bridge] [PATCH] Crash on "brctl stp br0"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1751054372-1107390248=:19651
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello!

"brctl stp br0" would crash brctl provided that br0 is a bridge.  This is 
caused by incorrect number of arguments in the commands table. "stp" needs 
at least 2 arguments after "stp".  The patch against version 1.0.4 is 
attached.

-- 
Regards,
Pavel Roskin
--8323328-1751054372-1107390248=:19651
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=stp_crash.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0502021924080.19651@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=stp_crash.diff

LS0tIGJyY3RsL2JyY3RsX2NtZC5jDQorKysgYnJjdGwvYnJjdGxfY21kLmMN
CkBAIC0zOTQsNyArMzk0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjb21t
YW5kIGNvbW1hbmRzW10gPQ0KIAkgICI8YnJpZGdlPlx0XHRzaG93IGEgbGlz
dCBvZiBtYWMgYWRkcnMifSwNCiAJeyAxLCAic2hvd3N0cCIsIGJyX2NtZF9z
aG93c3RwLCANCiAJICAiPGJyaWRnZT5cdFx0c2hvdyBicmlkZ2Ugc3RwIGlu
Zm8ifSwNCi0JeyAxLCAic3RwIiwgYnJfY21kX3N0cCwNCisJeyAyLCAic3Rw
IiwgYnJfY21kX3N0cCwNCiAJICAiPGJyaWRnZT4gPHN0YXRlPlx0dHVybiBz
dHAgb24vb2ZmIiB9LA0KIH07DQogDQo=

--8323328-1751054372-1107390248=:19651--

Date: Wed, 2 Feb 2005 19:20:51 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
Message-ID: <Pine.LNX.4.62.0502021914300.19651@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-154342888-1107390051=:19651"
Subject: [Bridge] [PATCH] Better test for libsysfs
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

--8323328-154342888-1107390051=:19651
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello!

Testing for a library is not sufficient if you also need the headers. 
Many distributions install libraries without headers by default.  This is 
the case for Fedora Core 3 and libsysfs.  The library is in sysfsutils, 
but the headers are in sysfsutils-devel.

The patch for configure.in tests for both the headers and the library and 
makes the configure script print a warning if libsysfs cannot be used.

The patch is against bridge-utils-1.0.4.

-- 
Regards,
Pavel Roskin
--8323328-154342888-1107390051=:19651
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=libsysfs.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0502021920510.19651@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=libsysfs.diff

LS0tIGNvbmZpZ3VyZS5pbg0KKysrIGNvbmZpZ3VyZS5pbg0KQEAgLTI0LDcg
KzI0LDE0IEBADQogQUNfRlVOQ19NRU1DTVANCiBBQ19DSEVDS19GVU5DUyhn
ZXRob3N0bmFtZSBzb2NrZXQgc3RyZHVwIHVuYW1lKQ0KIEFDX0NIRUNLX0ZV
TkNTKGlmX25hbWV0b2luZGV4IGlmX2luZGV4dG9uYW1lKQ0KLUFDX0NIRUNL
X0xJQihzeXNmcywgc3lzZnNfb3Blbl9kaXJlY3RvcnkpDQorDQorZG5sIENo
ZWNrIGZvciBsaWJzeXNmcw0KK2xpYnN5c2ZzX2ZvdW5kPTANCitBQ19DSEVD
S19IRUFERVIoc3lzZnMvbGlic3lzZnMuaCwNCisJCVtBQ19DSEVDS19MSUIo
c3lzZnMsIHN5c2ZzX29wZW5fZGlyZWN0b3J5LCBsaWJzeXNmc19mb3VuZD0x
KV0pDQoraWYgdGVzdCAkbGlic3lzZnNfZm91bmQgIT0gMTsgdGhlbg0KKwlB
Q19NU0dfV0FSTihbQ29tcGlsaW5nIHdpdGhvdXQgbGlic3lzZnMgc3VwcG9y
dCFdKQ0KK2ZpDQogDQogQUNfU1VCU1QoS0VSTkVMX0hFQURFUlMpDQogDQo=

--8323328-154342888-1107390051=:19651--

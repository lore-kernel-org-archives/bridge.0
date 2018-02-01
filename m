Return-Path: <davem@davemloft.net>
Date: Thu, 01 Feb 2018 09:48:05 -0500 (EST)
Message-Id: <20180201.094805.1174548294600347835.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
References: <1517480728-5580-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
Subject: Re: [Bridge] [PATCH] net: bridge: Fix uninitialized error in
 br_fdb_sync_static()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: geert@linux-m68k.org
Cc: arnd@arndb.de, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCkRhdGU6IFRo
dSwgIDEgRmViIDIwMTggMTE6MjU6MjcgKzAxMDANCg0KPiBXaXRoIGdjYy00LjEuMi46DQo+IA0K
PiAgICAgbmV0L2JyaWRnZS9icl9mZGIuYzogSW4gZnVuY3Rpb24goWJyX2ZkYl9zeW5jX3N0YXRp
Y6I6DQo+ICAgICBuZXQvYnJpZGdlL2JyX2ZkYi5jOjk5Njogd2FybmluZzogoWVycqIgbWF5IGJl
IHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uDQo+IA0KPiBJbmRlZWQsIGlmIHRo
ZSBsaXN0IGlzIGVtcHR5LCBlcnIgd2lsbCBiZSB1bmluaXRpYWxpemVkLCBhbmQgd2lsbCBiZQ0K
PiBwcm9wYWdhdGVkIHVwIGFzIHRoZSBmdW5jdGlvbiByZXR1cm4gdmFsdWUuDQo+IA0KPiBGaXgg
dGhpcyBieSBwcmVpbml0aWFsaXppbmcgZXJyIHRvIHplcm8uDQo+IA0KPiBGaXhlczogZWI3OTM1
ODMwZDAwYjllMCAoIm5ldDogYnJpZGdlOiB1c2Ugcmhhc2h0YWJsZSBmb3IgZmRicyIpDQo+IFNp
Z25lZC1vZmYtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQoN
CkFwcGxpZWQsIHRoYW5rcyBHZWVydC4NCg==

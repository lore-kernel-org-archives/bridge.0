Return-Path: <davem@davemloft.net>
Date: Fri, 23 Mar 2018 12:41:33 -0400 (EDT)
Message-Id: <20180323.124133.2009910638975659955.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521822426-18563-1-git-send-email-nikolay@cumulusnetworks.com>
References: <20180322153406.17760-1-3chas3@gmail.com>
	<1521822426-18563-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
Subject: Re: [Bridge] [PATCH net-next] net: bridge: fix direct access to
 bridge vlan_enabled and use helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, 3chas3@gmail.com

RnJvbTogTmlrb2xheSBBbGVrc2FuZHJvdiA8bmlrb2xheUBjdW11bHVzbmV0d29ya3MuY29tPg0K
RGF0ZTogRnJpLCAyMyBNYXIgMjAxOCAxODoyNzowNiArMDIwMA0KDQo+IFdlIG5lZWQgdG8gdXNl
IGJyX3ZsYW5fZW5hYmxlZCgpIGhlbHBlciBvdGhlcndpc2Ugd2UnbGwgYnJlYWsgYnVpbGRzDQo+
IHdpdGhvdXQgYnJpZGdlIHZsYW5zOg0KPiBuZXQvYnJpZGdlLy9icl9pZi5jOiBJbiBmdW5jdGlv
biChYnJfbXR1ojoNCj4gbmV0L2JyaWRnZS8vYnJfaWYuYzo0NTg6ODogZXJyb3I6IKFjb25zdCBz
dHJ1Y3QgbmV0X2JyaWRnZaIgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCChdmxhbl9lbmFibGVkog0K
PiAgIGlmIChici0+dmxhbl9lbmFibGVkKQ0KPiAgICAgICAgIF4NCj4gbmV0L2JyaWRnZS8vYnJf
aWYuYzo0NjI6MTogd2FybmluZzogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZA0KPiBm
dW5jdGlvbiBbLVdyZXR1cm4tdHlwZV0NCj4gIH0NCj4gIF4NCj4gc2NyaXB0cy9NYWtlZmlsZS5i
dWlsZDozMjQ6IHJlY2lwZSBmb3IgdGFyZ2V0ICduZXQvYnJpZGdlLy9icl9pZi5vJw0KPiBmYWls
ZWQNCj4gDQo+IEZpeGVzOiA0MTlkMTRhZjllMDcgKCJicmlkZ2U6IEFsbG93IG1heCBNVFUgd2hl
biBtdWx0aXBsZSBWTEFOcyBwcmVzZW50IikNCj4gU2lnbmVkLW9mZi1ieTogTmlrb2xheSBBbGVr
c2FuZHJvdiA8bmlrb2xheUBjdW11bHVzbmV0d29ya3MuY29tPg0KDQpBcHBsaWVkLCB0aGFua3Mg
Zm9yIHJlc3BvbmRpbmcgdG8gdGhpcyBpc3N1ZSBzbyBxdWlja2x5Lg0K

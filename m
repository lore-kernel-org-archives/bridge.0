Return-Path: <xqjcool@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=T29RIM85FApJ7NeXpxqxpMXowSbMtr9aelB2ck2byeQ=;
	b=Np4fpnE7OQYpDB0cbv6kyQTHkcmVAPsSscu+PpjkmIY/ViPS3ohIsXO3URpW7IOCUD
	qNS5xgVP/41q1/kD76K9IN9J/CNQHwKdbDnzw8lYabL8NodbaP+pbV90Q1HCVzTGQYXE
	2KrSpqdAIZvXmuLu+yb8fCMhN7ozCkuHIKr3RQjiSi3DI3sbIxK94o6p8LxERtJQDbQO
	f/RY03xjl7QpG+STmbPfhhtwKVxu3pk7wwDurn+JQfuhjyK//p8r2nChfo7s8FmbdfBp
	IC/n1tMQuOYnxhQcA0P+LMSWPHsi7vs0AXyynbXN31m4j3y3YeOc+uoBumISQHs2g6du
	dsdA==
MIME-Version: 1.0
From: =?UTF-8?B?6YKi5bqG5p2w?= <xqjcool@gmail.com>
Date: Sat, 6 Jan 2018 17:25:20 +0800
Message-ID: <CAOtoAkc_prks5PcRtwqh2Agp0TTT2jY4jpQzOoi_CgiSPjST-w@mail.gmail.com>
Content-Type: multipart/mixed; boundary="089e082bc9c0de722005621824a9"
Subject: [Bridge] [PATCH 3.2 01/06] "bridge should send gratuitous ARP to
 notify peer while a bond, which is a port of this bridge, changes."
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org

--089e082bc9c0de722005621824a9
Content-Type: multipart/alternative; boundary="089e082bc9c0de721e05621824a7"

--089e082bc9c0de721e05621824a7
Content-Type: text/plain; charset="UTF-8"

We create bond0 and add eth0&eth1 as slaves. Eth0 is active. Then we add
bond0
into br0 as a bridge port. Br0 has ip address. When eth0 is down, after
bond0's
failover eth1 become active. At this moment, we need br0 send a gratuitous
ARP
to notify peer to update ARP table.

Signed-off-by: Xing.Qingjie <xqjcool@gmail.com>
---
 net/bridge/br_notify.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
diff --git a/net/bridge/br_notify.c b/net/bridge/br_notify.c
index a76b621..90cf123 100644
--- a/net/bridge/br_notify.c
+++ b/net/bridge/br_notify.c
@@ -34,6 +34,7 @@ static int br_device_event(struct notifier_block *unused,
unsigned long event, v
        struct net_device *dev = ptr;
        struct net_bridge_port *p;
        struct net_bridge *br;
+       struct in_device *in_dev;
        bool changed_addr;
        int err;
@@ -102,6 +103,17 @@ static int br_device_event(struct notifier_block
*unused, unsigned long event, v
        case NETDEV_PRE_TYPE_CHANGE:
                /* Forbid underlaying device to change its type. */
                return NOTIFY_BAD;
+
+       case NETDEV_NOTIFY_PEERS:
+               /* Send gratuitous arp while bond,a port of bridge, changes
*/
+               if (dev->priv_flags & IFF_BONDING && dev->flags &
IFF_MASTER) {
+                       in_dev = __in_dev_get_rtnl(br->dev);
+
+                       ASSERT_RTNL();
+                       if (in_dev)
+                               inetdev_send_gratuitous_arp(br->dev,
in_dev);
+               }
+               break;
        }
        /* Events that may cause spanning tree to refresh */
--
1.7.1

--089e082bc9c0de721e05621824a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5XZSBjcmVhdGUgYm9uZDAgYW5kIGFkZCBldGgwJmFtcDtldGgx
IGFzIHNsYXZlcy4gRXRoMCBpcyBhY3RpdmUuIFRoZW4gd2UgYWRkIGJvbmQwPGJyPmludG8gYnIw
IGFzIGEgYnJpZGdlIHBvcnQuIEJyMCBoYXMgaXAgYWRkcmVzcy4gV2hlbiBldGgwIGlzIGRvd24s
IGFmdGVyIGJvbmQwJiMzOTtzPGJyPmZhaWxvdmVyIGV0aDEgYmVjb21lIGFjdGl2ZS4gQXQgdGhp
cyBtb21lbnQsIHdlIG5lZWQgYnIwIHNlbmQgYSBncmF0dWl0b3VzIEFSUDxicj50byBub3RpZnkg
cGVlciB0byB1cGRhdGUgQVJQIHRhYmxlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+U2lnbmVk
LW9mZi1ieTogWGluZy5RaW5namllICZsdDs8YSBocmVmPSJtYWlsdG86eHFqY29vbEBnbWFpbC5j
b20iPnhxamNvb2xAZ21haWwuY29tPC9hPiZndDs8YnI+LS0tPGJyPsKgbmV0L2JyaWRnZS9icl9u
b3RpZnkuYyB8wqDCoCAxMiArKysrKysrKysrKys8YnI+wqAxIGZpbGVzIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pPC9kaXY+PGRpdj5kaWZmIC0tZ2l0IGEvbmV0L2Jy
aWRnZS9icl9ub3RpZnkuYyBiL25ldC9icmlkZ2UvYnJfbm90aWZ5LmM8YnI+aW5kZXggYTc2YjYy
MS4uOTBjZjEyMyAxMDA2NDQ8YnI+LS0tIGEvbmV0L2JyaWRnZS9icl9ub3RpZnkuYzxicj4rKysg
Yi9uZXQvYnJpZGdlL2JyX25vdGlmeS5jPGJyPkBAIC0zNCw2ICszNCw3IEBAIHN0YXRpYyBpbnQg
YnJfZGV2aWNlX2V2ZW50KHN0cnVjdCBub3RpZmllcl9ibG9jayAqdW51c2VkLCB1bnNpZ25lZCBs
b25nIGV2ZW50LCB2PGJyPsKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBw
dHI7PGJyPsKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnA7PGJyPsKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBuZXRfYnJpZGdlICpicjs8YnI+K8KgwqDCoMKgwqDCoCBzdHJ1Y3Qg
aW5fZGV2aWNlICppbl9kZXY7PGJyPsKgwqDCoMKgwqDCoMKgIGJvb2wgY2hhbmdlZF9hZGRyOzxi
cj7CoMKgwqDCoMKgwqDCoCBpbnQgZXJyOzwvZGl2PjxkaXY+QEAgLTEwMiw2ICsxMDMsMTcgQEAg
c3RhdGljIGludCBicl9kZXZpY2VfZXZlbnQoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICp1bnVzZWQs
IHVuc2lnbmVkIGxvbmcgZXZlbnQsIHY8YnI+wqDCoMKgwqDCoMKgwqAgY2FzZSBORVRERVZfUFJF
X1RZUEVfQ0hBTkdFOjxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRm9yYmlk
IHVuZGVybGF5aW5nIGRldmljZSB0byBjaGFuZ2UgaXRzIHR5cGUuICovPGJyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTk9USUZZX0JBRDs8YnI+Kzxicj4rwqDCoMKgwqDC
oMKgIGNhc2UgTkVUREVWX05PVElGWV9QRUVSUzo8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogU2VuZCBncmF0dWl0b3VzIGFycCB3aGlsZSBib25kLGEgcG9ydCBvZiBicmlkZ2Us
IGNoYW5nZXMgKi88YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0mZ3Q7
cHJpdl9mbGFncyAmYW1wOyBJRkZfQk9ORElORyAmYW1wOyZhbXA7IGRldi0mZ3Q7ZmxhZ3MgJmFt
cDsgSUZGX01BU1RFUikgezxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW5fZGV2ID0gX19pbl9kZXZfZ2V0X3J0bmwoYnItJmd0O2Rldik7PGJyPis8YnI+
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFTU0VSVF9SVE5M
KCk7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
aW5fZGV2KTxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGluZXRkZXZfc2VuZF9ncmF0dWl0b3VzX2FycChici0mZ3Q7ZGV2LCBp
bl9kZXYpOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOzxicj7CoMKgwqDCoMKgwqDCoCB9PC9kaXY+PGRpdj7C
oMKgwqDCoMKgwqDCoCAvKiBFdmVudHMgdGhhdCBtYXkgY2F1c2Ugc3Bhbm5pbmcgdHJlZSB0byBy
ZWZyZXNoICovPGJyPi0tPGJyPjEuNy4xPGJyPjwvZGl2PjwvZGl2Pg0K
--089e082bc9c0de721e05621824a7--

--089e082bc9c0de722005621824a9
Content-Type: application/octet-stream; 
	name="0001-bridge-should-send-gratuitous-ARP-to-notify-peer-whi.patch"
Content-Disposition: attachment; 
	filename="0001-bridge-should-send-gratuitous-ARP-to-notify-peer-whi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jc357fxw0

RnJvbSAzMDQwOTkwNTQyY2E1ZTQyNzZmOWQ5MjE1ZDQ1NTZjOWUyMmNjNTgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaW5nLlFpbmdqaWUgPHhxamNvb2xAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDYgU2VwIDIwMTcgMDQ6MDM6MjUgKzA4MDAKU3ViamVjdDogW1BBVENIXSBicmlkZ2Ug
c2hvdWxkIHNlbmQgZ3JhdHVpdG91cyBBUlAgdG8gbm90aWZ5IHBlZXIgd2hpbGUgYSBib25kLCB3
aGljaAogaXMgYSBwb3J0IG9mIHRoaXMgYnJpZGdlLCBjaGFuZ2VzLgoKV2UgY3JlYXRlIGJvbmQw
IGFuZCBhZGQgZXRoMCZldGgxIGFzIHNsYXZlcy4gRXRoMCBpcyBhY3RpdmUuIFRoZW4gd2UgYWRk
IGJvbmQwCmludG8gYnIwIGFzIGEgYnJpZGdlIHBvcnQuIEJyMCBoYXMgaXAgYWRkcmVzcy4gV2hl
biBldGgwIGlzIGRvd24sIGFmdGVyIGJvbmQwJ3MKZmFpbG92ZXIgZXRoMSBiZWNvbWUgYWN0aXZl
LiBBdCB0aGlzIG1vbWVudCwgd2UgbmVlZCBicjAgc2VuZCBhIGdyYXR1aXRvdXMgQVJQCnRvIG5v
dGlmeSBwZWVyIHRvIHVwZGF0ZSBBUlAgdGFibGUuCgpTaWduZWQtb2ZmLWJ5OiBYaW5nLlFpbmdq
aWUgPHhxamNvb2xAZ21haWwuY29tPgotLS0KIG5ldC9icmlkZ2UvYnJfbm90aWZ5LmMgfCAgIDEy
ICsrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL25ldC9icmlkZ2UvYnJfbm90aWZ5LmMgYi9uZXQvYnJpZGdl
L2JyX25vdGlmeS5jCmluZGV4IGE3NmI2MjEuLjkwY2YxMjMgMTAwNjQ0Ci0tLSBhL25ldC9icmlk
Z2UvYnJfbm90aWZ5LmMKKysrIGIvbmV0L2JyaWRnZS9icl9ub3RpZnkuYwpAQCAtMzQsNiArMzQs
NyBAQCBzdGF0aWMgaW50IGJyX2RldmljZV9ldmVudChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnVu
dXNlZCwgdW5zaWduZWQgbG9uZyBldmVudCwgdgogCXN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBw
dHI7CiAJc3RydWN0IG5ldF9icmlkZ2VfcG9ydCAqcDsKIAlzdHJ1Y3QgbmV0X2JyaWRnZSAqYnI7
CisJc3RydWN0IGluX2RldmljZSAqaW5fZGV2OwogCWJvb2wgY2hhbmdlZF9hZGRyOwogCWludCBl
cnI7CiAKQEAgLTEwMiw2ICsxMDMsMTcgQEAgc3RhdGljIGludCBicl9kZXZpY2VfZXZlbnQoc3Ry
dWN0IG5vdGlmaWVyX2Jsb2NrICp1bnVzZWQsIHVuc2lnbmVkIGxvbmcgZXZlbnQsIHYKIAljYXNl
IE5FVERFVl9QUkVfVFlQRV9DSEFOR0U6CiAJCS8qIEZvcmJpZCB1bmRlcmxheWluZyBkZXZpY2Ug
dG8gY2hhbmdlIGl0cyB0eXBlLiAqLwogCQlyZXR1cm4gTk9USUZZX0JBRDsKKworCWNhc2UgTkVU
REVWX05PVElGWV9QRUVSUzoKKwkJLyogU2VuZCBncmF0dWl0b3VzIGFycCB3aGlsZSBib25kLGEg
cG9ydCBvZiBicmlkZ2UsIGNoYW5nZXMgKi8KKwkJaWYgKGRldi0+cHJpdl9mbGFncyAmIElGRl9C
T05ESU5HICYmIGRldi0+ZmxhZ3MgJiBJRkZfTUFTVEVSKSB7CisJCQlpbl9kZXYgPSBfX2luX2Rl
dl9nZXRfcnRubChici0+ZGV2KTsKKworCQkJQVNTRVJUX1JUTkwoKTsKKwkJCWlmIChpbl9kZXYp
CisJCQkJaW5ldGRldl9zZW5kX2dyYXR1aXRvdXNfYXJwKGJyLT5kZXYsIGluX2Rldik7CisJCX0K
KwkJYnJlYWs7CiAJfQogCiAJLyogRXZlbnRzIHRoYXQgbWF5IGNhdXNlIHNwYW5uaW5nIHRyZWUg
dG8gcmVmcmVzaCAqLwotLSAKMS43LjEKCg==
--089e082bc9c0de722005621824a9--

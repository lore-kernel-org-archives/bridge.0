Message-ID: <20040721032857.14239.qmail@web15208.mail.bjs.yahoo.com>
Date: Wed, 21 Jul 2004 11:28:57 +0800 (CST)
From: =?gb2312?q?Zhou=20Ping?= <zhouping_jay@yahoo.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1090380546-31745-125"
Subject: [Bridge] Help: bridging eth0 and wlan0?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------------=_1090380546-31745-125
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGVsbG8gYWxsLAoKSSdtIHRyeWluZyB0byBicmlkZ2UgdGhlIHdsYW4wIGFuZCBldGgwIG9uIGFu
IGVtYmVkZGVkCnN5c3RlbS4gSSB1c2VkIHRoZSBmb2xsb3dpbmcgY29tbWFuZHMgdG8gc2V0dXAg
dGhlCmJyaWRnZToKCmlmY29uZmlnIGV0aDAgMC4wLjAuMCBwcm9taXNjdW91cwppZmNvbmZpZyB3
bGFuMCAwLjAuMC4wIHByb21pc2N1b3VzCmJyY3RsIGFkZGJyIGJyMApicmN0bCBhZGRpZiBicjAg
ZXRoMApicmN0bCBhZGRpZiBicjAgd2xhbjAKYnJjdGwgc2V0aGVsbG8gYnIwIDEKYnJjdGwgc2V0
bWF4YWdlIGJyMCA0CmJyY3RsIHNldGZkIGJyMCA0CmlmY29uZmlnIGJyMCB1cAoKVGhlIGV0aDAg
aXMgY29ubmVjdGVkIHRvIGEgbG9jYWwgbmV0d29yaywgYW5kIHdsYW4wIGlzCnNldCB0byBBZC1o
b2MgbW9kZSB3aXRoIHByb3BlciBTU0lELiBBZnRlciB0aGUgYnJpZGdlCmlzIHN0YWJsaXplZCwg
SSB1c2UgZGhjbGllbnQgdG8gYXNzaWduIGFuIElQIGZvciBicjAuClRoZW4gSSB1c2UgYSBsYXB0
b3AgdG8gY29ubmVjdCB0byB0aGUgYnJpZGdlLiBJIGNvdWxkCnBpbmcgdGhlIGJyaWRnZSAoYnIw
KSwgaG93ZXZlciBJIGNvdWxkIG5vdCBhY2Nlc3MgdGhlCmxvY2FsIG5ldHdvcmsgdGhyb3VnaCB0
aGUgYnJpZGdlLiBJJ20gY29uZnVzZWQgYnkKdGhpcy4gSXQgd29ya2VkIHdlbGwgd2l0aCAyIGV0
aGVybmV0IHBvcnRzLiBJIHdvbmRlcgppZiB0aGVyZSBpcyBhbnkgYWRkaXRpb25hbCBjb25maWd1
cmF0aW9ucyBuZWVkIHRvIGJlCnNldC4gRG9lcyBhbnlvbmUgaGF2ZSBhbnkgaWRlYSBvbiB0aGlz
PyBUaGFua3MuCgpCZXN0IHJlZ2FyZHMsClpob3UgUGluZy4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRG8gWW91IFlhaG9vIT8Kw8DF
rsP30MfTptPQvqHT0KOsItK7y9Eiy9Gx6cPAzbyhotHezby6zb/hzbwKaHR0cDovL2ltYWdlLnlp
c291LmNvbQogCjEwMNXX08rP5Lm7sru5u9PDo7/RxbuitefTytfU1vrAqcjdo6EKaHR0cDovL2Nu
LnJkLnlhaG9vLmNvbS9tYWlsX2NuL3RhZy8xMDBtLypodHRwOi8vY24ucHJvbW8ueWFob28uY29t
L21pbmlzaXRlLzEwMG0vCg==

------------=_1090380546-31745-125
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

Spam detection software, running on the system "fire-2.osdl.org", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or block
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  Hello all, I'm trying to bridge the wlan0 and eth0 on
  an embedded system. I used the following commands to setup the bridge:
  ifconfig eth0 0.0.0.0 promiscuous ifconfig wlan0 0.0.0.0 promiscuous
  brctl addbr br0 brctl addif br0 eth0 brctl addif br0 wlan0 brctl
  sethello br0 1 brctl setmaxage br0 4 brctl setfd br0 4 ifconfig br0 up
  [...] 

Content analysis details:   (5.4 points, 5.0 required)

 pts rule name              description
---- ---------------------- --------------------------------------------------
 3.2 CHARSET_FARAWAY_HEADER A foreign language charset used in headers
 2.2 MIME_CHARSET_FARAWAY   MIME character set indicates foreign language



------------=_1090380546-31745-125--

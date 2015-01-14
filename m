Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=v7G8/gq3wLz3rncXTeghprxJDI3TcDiqZNAuLbRAgzE=;
	b=B+zDpr53mRpOmjpMDTw64Dvf/7GOorYW5fhOYiBkyM7iizRkWHaXUceGne3LAUWVgx
	15lvEkL4wKO6VzC67fJ213P+rEEu+Jf91H4R7ucZFbeYPBrl+HMtNv7inPlVbvWhD6Qv
	gPNEj6gsEANeb+5fl8Wvj8OyU4jcTD8HZ6WNapFg+PDLtyf5pfGY7yuexjH4ctNlRxve
	z147dFiKoYfdcP7ZaFOwOsUL/LQUeEQASDks3mE7Xzby11UDIOfR56EP3mEIhs9qr6v4
	SYLmUc0RTDBjjRF7hU8lQBATCz2/O8Mj1X/76U4BeJKeE5ONp6Sdu9NCt3DMzY6PMwgI
	35QQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 14 Jan 2015 09:52:10 -0800
Message-Id: <1421257932-11073-1-git-send-email-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 0/2] net: DSA fixes for bridge and
	ip-autoconf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, kaber@trash.net, davem@davemloft.net, buytenh@wantstofly.org

Hi David,

These two patches address some real world use cases of the DSA master and slave
network devices.

You have already seen patch 1 previously and you rejected it since my
explanations were not good enough to provide a justification as to why it is
useful, hopefully this time my explanation is better.

Patch 2 solves a different, yet very real problem as well at the bridge layer
when using DSA network devices.

Thanks!

Florian Fainelli (2):
  net: ipv4: handle DSA enabled master network devices
  net: bridge: reject DSA-enabled master netdevices as bridge members

 net/bridge/br_if.c  | 10 ++++++++--
 net/ipv4/ipconfig.c | 10 +++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.1.0


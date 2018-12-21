Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
	t=1545405322; h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:in-reply-to:
	references; bh=lTRJUL0Yahq7JN1bW0uPxHC2MDoSg3ibls3Avb5GR/M=;
	b=s388RoDaer9X9snNErQYSgRYEE3Cqz6AwiN/eWp1+DF6xTfx/xnavfbF7FiZow/4JIbxNY
	xxzEC7l87k1N3FqTUInpB4eDOQUHBgwGNppm3UBbjD19yJXEgXMZS7Tf/hMwVZUZ9UQQSN
	B2Xq12Qvu5w7bh11BE7+MK0+01eM6+894dE1KaDhm6UMGmxzRTLpIZTK5vXFVVQlCmeJjo
	B+Xqb30fa11POH66OAr8YNztSEYOgM9zXRw24is0SFTXBLkfCHWef95MOK3ymxRuA279gf
	Fiyxwm7f5NYmenxcvjCq5WX/UOEAzBV1iedyBAR2a9oyIlPj9HuEfh2dmDhgsQ==
Date: Fri, 21 Dec 2018 16:15:07 +0100
Message-Id: <20181221151511.14923-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/4] bridge: implement Multicast Router
	Discovery (RFC4286)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S . Miller" <davem@davemloft.net>

Hi,

This patchset adds initial Multicast Router Discovery support to
the Linux bridge (RFC4286). With MRD it is possible to detect multicast
routers and mark bridge ports and forward multicast packets to such routers
accordingly.

So far, multicast routers are detected via IGMP/MLD queries and PIM
messages in the Linux bridge. As there is only one active, selected
querier at a time RFC4541 ("Considerations for Internet Group Management
Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
Switches") section 2.1.1.a) recommends snooping Multicast Router
Advertisements as provided by MRD (RFC4286).


The first two patches are refactoring some existing code which is reused
for parsing the Multicast Router Advertisements later in the fourth
patch. The third patch lets the bridge join the all-snoopers multicast
address to be able to reliably receive the Multicast Router
Advertisements.


What is not implemented yet from RFC4286 yet:

* Sending Multicast Router Solicitations:
  -> RFC4286: "[...] may be sent when [...] an interface is
     (re-)initialized [or] MRD is enabled"
* Snooping Multicast Router Terminations:
  -> currently this only relies on our own timeouts
* Adjusting timeouts with the values provided in the announcements


Regards, Linus




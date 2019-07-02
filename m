Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=z8dZZIPpeZ1Qw73KcIU6q0OGE71quMthD7zEmsELvnY=;
	b=WaX5g02y0EPpCZNkzhaCztvLQ4Ru36Q/9DnYFyUVnT0Lt2Ro7A+fs9wicsQPbmRCRB
	4CRVtdcJRyW27MwQnkNt+FgU/9GS5MdEme98/kchdypCjlY0t9uaTr0Lrop/lxd1XHgk
	erq8PbI4Sm3m38nhYGFMzmqGR5/S8/Jvpj4CQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Tue,  2 Jul 2019 15:00:17 +0300
Message-Id: <20190702120021.13096-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/4] net: bridge: fix possible stale skb
	pointers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: martin@linuxlounge.net, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, yoshfuji@linux-ipv6.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

Hi,
In the bridge driver we have a couple of places which call pskb_may_pull
but we've cached skb pointers before that and use them after which can
lead to out-of-bounds/stale pointer use. I've had these in my "to fix"
list for some time and now we got a report (patch 01) so here they are.
Patches 02-04 are fixes based on code inspection. Also patch 01 was
tested by Martin Weinelt, Martin if you don't mind please add your
tested-by tag to it by replying with Tested-by: name <email>.
I've also briefly tested the set by trying to exercise those code paths.

Thanks,
 Nik

Nikolay Aleksandrov (4):
  net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report
    handling
  net: bridge: mcast: fix stale ipv6 hdr pointer when handling v6 query
  net: bridge: don't cache ether dest pointer on input
  net: bridge: stp: don't cache eth dest pointer before skb pull

 net/bridge/br_input.c     |  8 +++-----
 net/bridge/br_multicast.c | 23 +++++++++++++----------
 net/bridge/br_stp_bpdu.c  |  3 +--
 3 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.21.0


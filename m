Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 25 May 2014 07:03:21 +0200
Message-Id: <1400994205-31165-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCHv2 net-next 0/4] bridge: multicast snooping patches
	/ exports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>

Changes in v2:

* fix a nasty typo in PATCH 1/4, br_multicast_update_query_timer():
  "br->multicast_query_interval" vs. "br->multicast_querier_interval"
  => this accidentally reduced the other querier present timer 
     from 255 to 125 seconds
* fix a typo in PATCH 2/4, br_ip{4,6}_multicast_query():
  ntohs(ETH_P_{IP,IPV6}) vs. htons(ETH_P_{IP,IPV6})
* add missing ntohl()s before address comparison in PATCH 2/4,
  br_ip4_multicast_select_querier() (thanks David!)

Cheers, Linus



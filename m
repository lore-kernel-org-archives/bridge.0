Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=/QL3qjq3n13D0RA32+XzF8FWvSXarZUAeteVYp7C+mo=;
	b=OXnKREBnqpi+aFf1FW/MuSne4In9Ehl6iCJQjlJbmHwwdkH7jTHtxEIdxOPyFd68JG
	p17PV4owdemZmcAYLTFbocoZLaMgVwmrf8GGd+SDDDFTVbfP3U6E+XU2sHG+bPp+w203
	tbnF3KhRVSw6Pie5J4xV2sk+Qp3TeHIW5V9mk=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 17 Aug 2016 12:53:08 +0200
Message-Id: <1471431190-27442-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: export vlan stats
	per-port with flags
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
This set adds the ability to export vlan stats per-port. Patch 01 makes
that possible by consolidating the bridge and port linkxstats calls. Then
patch 02 allows to dump the vlan entry flags in order to be able to
distinguish between bridge and port vlan entries when dumping the master
device vlan stats. That is needed because that call was implemented when
the stats API didn't have slave dumping capabilities and it dumps all vlan
stats (for both bridge and port entries). We also need it in order to print
the vlan flags when dumping the stats.

Cheers,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: consolidate bridge and port linkxstats calls
  net: bridge: export vlan flags with the stats

 include/uapi/linux/if_bridge.h |   2 +-
 net/bridge/br_netlink.c        | 115 ++++++++++++++---------------------------
 2 files changed, 41 insertions(+), 76 deletions(-)

-- 
2.1.4


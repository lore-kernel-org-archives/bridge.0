Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mZq+Sk8sW5jspwNyA+rTh8cMrmM4ztbBKovfMaPUGUg=;
 b=KXA6npIPqfUwNZcrMvATfLw6O+OFtQCio8W/gFenkxYbF9I1oRLfS1zS9Io5qWwFn1
 fgUEEtRhtvE1czajEsGmNJ9G4+xWwB9eTtwl6Ca9XfEHZBhttJb3CGdTXVXk8A1jEyVY
 U/nV8j3q3cgq+tdSM+47ru+pp2elI6gLOJrh7zR37SKAq4+krFS1kHBVKnBxnBVgbTWK
 imnDplsyWHjDC/KOqlmL5/okaxbync87Fmm08XUw+spnfnyVS18WeTACSTXy7G+VymvD
 DaSBLskbUjbVEyuGkbBzeKAJSiJffJcoXDWBkWiG9kbH3ebNd7LzUNjESCZCPQeUWAcy
 SUrg==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Fri, 29 Jan 2021 13:51:40 +0200
Message-Id: <20210129115142.188455-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: drop hosts limit sysfs
	and add a comment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
As recently discussed[1] we should stop extending the bridge sysfs
support for new options and move to using netlink only, so patch 01
drops the recently added hosts limit sysfs support which is still in
net-next only and patch 02 adds comments in br_sysfs_br/if.c to warn
against adding new sysfs options.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: mcast: drop hosts limit sysfs support
  net: bridge: add warning comments to avoid extending sysfs

 net/bridge/br_sysfs_br.c |  4 ++++
 net/bridge/br_sysfs_if.c | 30 ++++--------------------------
 2 files changed, 8 insertions(+), 26 deletions(-)

-- 
2.29.2


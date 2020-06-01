Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=E3/24F62NlPLS0BZI
 KB9PKwWbUkHMjMffQEINIidQHQ=; b=h99Te+LTYj1fbOkSZ9lHj1daH8EbqhQo8
 GoNJTebbOCgOQRQJk5CgvW2dZiclE2QA49BYWUSXYP0H92LkxfODq94vp053YwYC
 OQbxWAyjhrdmwtlPS0NTVI7zmS3dOwfT9ZUydlfzUB9He2kfybLj/cC1NIj+/9O6
 3gO6Ekr6cBMjfy4drsMvjJHeMD4Xvsxi9gGwmzA4tqa+96aSbqYfS5jdwXPijtY2
 cqo4RFH+XJGufRNZdVkk3GcYsQAD/IrroEvUu9tjxF5KwVhdRufq19p2So+sNDc2
 z5GBFesqcqxa4ZYI9ASvAzLaBDsGrlkbHSq7j4D3FPjLsOfjLg/9Q==
From: Ido Schimmel <idosch@idosch.org>
Date: Mon,  1 Jun 2020 15:58:53 +0300
Message-Id: <20200601125855.1751343-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/2] Fix infinite loop in bridge and vxlan
	modules
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, dlstevens@us.ibm.com, Ido Schimmel <idosch@mellanox.com>, allas@mellanox.com, kuba@kernel.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

When suppressing invalid IPv6 Neighbour Solicitation messages, it is
possible for the bridge and vxlan modules to get stuck in an infinite
loop. See the individual changelogs for detailed explanation of the
problem and solution.

The bug was originally reported against the bridge module, but after
auditing the code base I found that the buggy code was copied from the
vxlan module. This patch set fixes both modules. Could not find more
instances of the problem.

Please consider both patches for stable releases.

Ido Schimmel (2):
  bridge: Avoid infinite loop when suppressing NS messages with invalid
    options
  vxlan: Avoid infinite loop when suppressing NS messages with invalid
    options

 drivers/net/vxlan.c          | 4 ++++
 net/bridge/br_arp_nd_proxy.c | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.26.2


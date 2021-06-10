Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=maUiGF2VHEUc5VH+pzNTaQe1wbHTLgvuD4shjy/n6kA=;
 b=B7oqlCKzvxSAB8tfvXE1A68qgl3c6c+nPkxYs8oW80EflWI6Oz19i2Jf2qWczzl0IU
 ufuhBiQRZIpGdTvrCBzsqA6ncmOzOfGe2mlePgX2k7tlAkkaW3ngVQ1yLQgOWRZm+7OL
 f7QiraeHc5enY8EeEwYLeq3Aju+Z7HBRu2PBg9d15OR+IoVtVRDfqsxlK/WwKqElP7V8
 AZv0M+zxt9NN69TKe0K0nJtVqtn6iS5/03SALVjeodX3p7xqwd11oz/7iJ+OzVtDrFP8
 mNfI4wDiSouOzQ8UW1JWoNTqOQz9zFnWR4w2G3Lr9wHb8hF7xhp4c7cwBpN4bN2KUcsR
 wktw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 10 Jun 2021 15:04:09 +0300
Message-Id: <20210610120411.128339-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/2 v2] net: bridge: vlan tunnel egress path
	fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
These two fixes take care of tunnel_dst problems in the vlan tunnel egress
path. Patch 01 fixes a null ptr deref due to the lockless use of tunnel_dst
pointer without checking it first, and patch 02 fixes a use-after-free
issue due to wrong dst refcounting (dst_clone() -> dst_hold_safe()).

Both fix the same commit and should be queued for stable backports:
Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")

v2: no changes, added stable list to CC

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: fix vlan tunnel dst null pointer dereference
  net: bridge: fix vlan tunnel dst refcnt when egressing

 net/bridge/br_private.h     |  4 ++--
 net/bridge/br_vlan_tunnel.c | 38 +++++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 16 deletions(-)

-- 
2.31.1


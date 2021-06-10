Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bwD7tLjIytzsF2Noid/CFwwwO+Xsa64mcNBZBhtUbeE=;
 b=f6CFykudWQOYyA9KqsAlp9KI46ZYLC6Te9Lw8jeyUv2CGnWxNth+pu/KdJPKoSaPRA
 nU+Sq8Sx8yAobNjY5IfBFG2SUU7jkZv54h495lhbPIKLI2tRwLNMmmcyRPJ/25r+yiy0
 KVsHgKrQ7Y/+GngOh0zc9CeGW89PQ0CemtWZRHsIYAjblQUUCkKvOsOUtMBwtP6CxWEY
 gM84BsOouAVSW1UsM9yen6iIdktkfTGyUkBKxSDxHSsqmxCrnrBqVKZl4XJKFkOmOMWr
 t4eGr2rnbjWUHc4dxznWvLvX79w2ql4W+tBNm0GOVxexxrdipxsU7CXrzrgJ1FNS5p0Z
 4Xuw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 10 Jun 2021 13:45:35 +0300
Message-Id: <20210610104537.119538-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/2] net: bridge: vlan tunnel egress path fixes
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
11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")

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


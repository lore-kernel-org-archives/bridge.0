Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=u7es23m68YE0yDAKWEjJ20E23kk4TJaXNmA2qr7JJH4=;
 b=L8oivNjMQSl9MPzjFbzVGxjlnBoiWGiLHMIq/oDJwCXUtR5AWy+eO/MMO/EOMD8F62
 dAn8Zv109J9ObyJa4YNpyo+ayqdoyqppliEDrOUUhUBsl7BScxW6Ilyidt0B+GZO/sLp
 1PJhZv6EsQlETlxh1kQq7Pa7T8E2lUxpNLk+WOmfvcpsmnvYb7vdlpeWsp6ab/ZWcvVQ
 SPlfbz2s9+GjpIPCRTk+1863QwHynHZrtyEKMoWav/zOQoIc93rrLCj+8C2xa5KPcEM2
 J6W8Ct1jNR/SdB+daDHjRGlZM3QbiT6PtmlXyFpxXz3eQMQFbrb6fB1KQX/fKaY7aIuW
 K5+Q==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 10:40:52 +0200
Message-Id: <20220411084054.298807-1-troglobit@gmail.com>
In-Reply-To: <20220223172407.175865-1-troglobit@gmail.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 0/2] net: bridge: add support for host
	l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Joachim Wiberg <troglobit@gmail.com>, "David S . Miller" <davem@davemloft.net>

Fix to an obvious omissions for layer-2 host mdb entries, this v2 adds
the missing selftest and some minor style fixes.

Note: this patch revealed some worrying problems in how the bridge
      forwards unknown BUM traffic and also how unknown multicast is
      forwarded when a IP multicast router is known, which a another
      (RFC) patch series intend to address.  That series will build
      on this selftest, hence the name of the test.

 /Joachim

v2:
  - Add braces to other if/else clauses (Jakub)
  - Add selftest to verify add/del of mac/ipv4/ipv6 mdb entries (Jakub)

Joachim Wiberg (2):
  net: bridge: add support for host l2 mdb entries
  selftests: forwarding: new test, verify host mdb entries

 net/bridge/br_mdb.c                           |  12 +-
 .../testing/selftests/net/forwarding/Makefile |   1 +
 .../selftests/net/forwarding/bridge_mdb.sh    | 103 ++++++++++++++++++
 3 files changed, 111 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_mdb.sh

-- 
2.25.1


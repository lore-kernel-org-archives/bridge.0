Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=56+H0JW/2Pf8Zd1MqwXSgnDI7f6wt6P7h2rgDhNLDzw=;
 b=2SWIhAmM/X3Wr1qK+Dv/WefXxS8j/OeK/rYdidcI2C8scWZphuHeyX+27t7ecpw0Yy
 IhDrog9fyOANod3Ks0XB7rUyIRphlclCh+nttWNI0WvJRwJA6CWT2Cv5eqCcr8jPu/P9
 ApimnWJ9MaqywU7Afg3cl3NxCXM4zsIaMmxfjY0aLBZTGt0ZL7XsFR1s0w5bJgLK0h5A
 hNOCCqOl7xDNa+BBrsFu9Rh+PvCkiN1u0mEZIdbJ1F2h1kRC9Tbb1JHWRQbVTa0EBZSe
 Y/w79cyZp7Jkxzz+T8ZkhltkXa6TIPMYIwvGQZxg37W6YjgAgG0xhzwQ8eQVHu479Te8
 h83Q==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Sun, 11 Jul 2021 12:56:27 +0300
Message-Id: <20210711095629.2986949-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 0/2] net: bridge: multicast: fix automatic
	router port marking races
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, stable@vger.kernel.org, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
While working on per-vlan multicast snooping I found two race conditions
when multicast snooping is enabled. They're identical and happen when
the router port list is modified without the multicast lock. One requires
a PIM hello message to be received on a port and the other an MRD
advertisement. To fix them we just need to take the multicast_lock when
adding the ports to the router port list (marking them as router ports).
Tested on an affected setup by generating the required packets while
modifying the port list in parallel.

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: multicast: fix PIM hello router port marking race
  net: bridge: multicast: fix MRD advertisement router port marking race

 net/bridge/br_multicast.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.31.1


Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z3HxhlcjFVfeTyolNsFE13TofseeVib/v3WCt+5AZBY=;
 b=YIl2GYpXvGrgpJUodUsU5XJOMKa8DPllLYd4a12ymeCI1rkodJiWdKD/6HonJF5ian
 unwbtoayynN2Gn0gTy6miC9gtThNlZbT4sT0V8DCZ/G8YB2s08vT/wfj4BuwwILLrrz5
 dqy27jZcbeoY+88NzzaIfhZrJNzBNZyfZA3+l5cIOO4hfoWKRXtFmJov8OV3IrvjeGNO
 lEKx3nuqH0qSLk66wkfmLg+96wGqyb02y8K8S6g62oOUjZf8DvDh1JVAQ9NeGP93QooJ
 npbtWJIqWekdJ9zW8Rl+IRWQPqvgozJcHXSMPn5RecGX0kWuH0+EbwDKAwYkRkPI1Sg5
 XRUw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 21 Jul 2021 17:01:25 +0300
Message-Id: <20210721140127.773194-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: multicast: add mdb and
	host context support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
This is a minor context improvement which chooses the proper multicast
context when adding user mdb entries or host-joined entries (pointing to
the bridge device). Patch 01 adds a helper which chooses the proper
context when user-space is adding an mdb entry, note that it requires
the vlan to be configured on at least 1 device (port or bridge) so it
would have a multicast context. Patch 02 changes br_multicast_host_join
to take a bridge multicast context parameter which is passed down from
the respective functions, currently it is used for the timer config
value only. This set is in preparation for adding all multicast options
for vlans.

Thanks,
 Nik


Nikolay Aleksandrov (2):
  net: bridge: multicast: add mdb context support
  net: bridge: multicast: add context support for host-joined groups

 net/bridge/br_mdb.c       | 45 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  8 +++----
 net/bridge/br_private.h   |  3 ++-
 3 files changed, 47 insertions(+), 9 deletions(-)

-- 
2.31.1


Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590739549; x=1622275549;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1j8r2lwJHp5ulvUar/6tSATkidOUKeT/fSsRUakAa/4=;
 b=cclR5EkC5um+2ZdnIr6XafLbAG5DNd1SwgVU4hh0izoLomJENqThOb7C
 ktV0+yVRbFeL1/cKmbtgtPSGRkS87/fYgLLbMqyERvYb3BlUMlSNOgiEv
 2V8vq7Aj4h+AxfgFXpMVOQiYGeFzOo4dUI6R4AiYu5Ei5BPmh6+9L4prW
 DTsyE+ttfXDoBVKS1GFhIoGhOiYoCY1ap+GcArVff6J1emkrI0hy9jN6Q
 2TOo9AwpmoNWNxj6xejeJzTNW9ZU9ydlMQ9NDofVclN+Kss/lPKawFLpE
 6FM3Ry3eJAhBxu5Nv7Dqee6wiLoP2RSMyfp0MnGSh/cJMNEKWl9AV9DgR w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 29 May 2020 10:05:12 +0000
Message-ID: <20200529100514.920537-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/2] bridge: mrp: Add support for MRA role
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends the MRP with the MRA role.
A node that has the MRA role can behave as a MRM or as a MRC. In case there are
multiple nodes in the topology that has the MRA role then only one node can
behave as MRM and all the others need to be have as MRC. The node that has the
higher priority(lower value) will behave as MRM.
A node that has the MRA role and behaves as MRC, it just needs to forward the
MRP_Test frames between the ring ports but also it needs to detect in case it
stops receiving MRP_Test frames. In that case it would try to behave as MRM.

Horatiu Vultur (2):
  bridge: mrp: Set the priority of MRP instance
  bridge: mrp: Add support for role MRA

 include/net/switchdev.h         |   2 +
 include/uapi/linux/if_bridge.h  |   4 +
 include/uapi/linux/mrp_bridge.h |  38 ++++++++++
 net/bridge/br_mrp.c             | 128 +++++++++++++++++++++++++++-----
 net/bridge/br_mrp_netlink.c     |  11 +++
 net/bridge/br_mrp_switchdev.c   |   5 +-
 net/bridge/br_private_mrp.h     |   5 +-
 7 files changed, 171 insertions(+), 22 deletions(-)

-- 
2.26.2


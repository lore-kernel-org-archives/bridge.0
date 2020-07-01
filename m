Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593588149; x=1625124149;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ASReo1CJm8170qaaG0UUzUeLV1c7HctXtdLcR5LMm/I=;
 b=tSnmokbPztLf4L//Jmmh+kI3T1295R0tcteFEYeZrFMg8hHiJsw4IipK
 nkl17KadobHgUm/tbPB5tL+9ahbCFvJQGcZs75nrNTDrSZ0W/KekTGor1
 /gZ8PXAydXYMmbxYWfhnEZqIDs++ipfHRFRYB+dhJYB5Cb6jk/MtJVrm0
 PETkvPF5125T2GcI6mS/Sa9rZVDulBBvgCHzk+z6FfbXg62JrEiS2fdHV
 q9KgrlknyLtqppaV5lrFyrE5xpRn2Czqt4uPUbxkljNoyrAv6Cp7RKLv8
 cNM6wo2cDk1BL3Wf1NKsiAtWF3Zjbne4CeCBz1KgZQleSlrUYwKQbvq/z Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 1 Jul 2020 09:21:17 +0200
Message-ID: <20200701072120.520571-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 0/3] bridge: mrp: Add support for
	getting the status
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series extends the MRP netlink interface to allow the userspace
daemon to get the status of the MRP instances in the kernel.

v2:
  - fix sparse warnings

Horatiu Vultur (3):
  bridge: uapi: mrp: Extend MRP attributes to get the status
  bridge: mrp: Add br_mrp_fill_info
  bridge: Extend br_fill_ifinfo to return MPR status

 include/uapi/linux/if_bridge.h | 17 +++++++++
 include/uapi/linux/rtnetlink.h |  1 +
 net/bridge/br_mrp_netlink.c    | 64 ++++++++++++++++++++++++++++++++++
 net/bridge/br_netlink.c        | 29 ++++++++++++++-
 net/bridge/br_private.h        |  7 ++++
 5 files changed, 117 insertions(+), 1 deletion(-)

-- 
2.27.0


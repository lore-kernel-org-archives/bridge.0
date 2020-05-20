Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1589973078; x=1621509078;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JsYCUzXlsDfKtKNFoYWxhgyWbE9JFx+fChYZvOyLb/8=;
 b=SUYQ1pucnAgYEwtQuj2gjBGZwjgXq454vsILk42bKqWu5a8oNbqXd6J6
 PZlBny0nuZciH4T2iTdqjARlNajgkMi6iZom5p9xgDlmpl5pAA3PsgtbX
 v/poxcSekk8fig4KObsS1toDVxctS0Mdb3EbPFW0kWCzrR3LS8+xzx/Nb
 dTmcS7MP3yB95pc+u7ngDp8rLjVXPGP5rKrnyViBt8J+8v+Tida0esDiN
 NNBFojgowf53pZfBoPoHo0KiKlUoqS0iJ+3FekcTTHOUtJEGp7zEfc30/
 sfARI+jno19elgLCtzckg9GwBM/9+JNNP7bqiSAxysfoPrSouuPuZ+EQ4 A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 20 May 2020 13:09:20 +0000
Message-ID: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 0/3] net: bridge: mrp: Add small fixes to MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch series adds small fixes to MRP implementation.
The following are fixed in this patch series:
- now is not allow to add the same port to multiple MRP rings
- remove unused variable
- restore the port state according to the bridge state when the MRP instance
  is deleted

Horatiu Vultur (3):
  bridge: mrp: Add br_mrp_unique_ifindex function
  switchdev: mrp: Remove the variable mrp_ring_state
  bridge: mrp: Restore port state when deleting MRP instance

 include/net/switchdev.h |  1 -
 net/bridge/br_mrp.c     | 44 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.26.2


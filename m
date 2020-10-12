Return-Path: <hkallweit1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=E6ZQVUiO2275Bcug8uUrW3WsykSr+byogH0GbMVRigw=;
 b=GcDfopve+WPhIRwCJrdYk1/TfRko9i65Ilpv8HZL+ED4dQxCulnQnRZePaC64NPAr2
 nmn49sDr6c5oTxnoaD2uTYlCVwQO8ZXYpcby1pF1D2C+klxUKxBdYIrvBNyVr+GmiuG8
 2bxGIzY8Kxom/n/9bHVET77PZ+zY76sAt0wT5b3JoLdHxzTW8+7RWqIDuoC4DkIKWI6m
 7HiNZNlq7bhlUSEqBASqo+IrjOTSLh2e3kzN+VzkPV5G32LDlCJJtFw4Om97uHa2w1yJ
 VkNWhQdsIVRQDbB1ucSjpnk/Fp3cj2MWiyRP9+YPlG7kqDkXi/dXv8baEtjIGqojK2hg
 0+vQ==
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
Date: Mon, 12 Oct 2020 10:00:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next v2 00/12] net: add and use function
 dev_fetch_sw_netstats for fetching pcpu_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>, Oliver Neukum <oneukum@suse.com>, Igor Mitsyanko <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@codeaurora.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Johannes Berg <johannes@sipsolutions.net>, Pravin B Shelar <pshelar@ovn.org>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, bridge@lists.linux-foundation.org

In several places the same code is used to populate rtnl_link_stats64
fields with data from pcpu_sw_netstats. Therefore factor out this code
to a new function dev_fetch_sw_netstats().

v2:
- constify argument netstats
- don't ignore netstats being NULL or an ERRPTR
- switch to EXPORT_SYMBOL_GPL

Heiner Kallweit (12):
  net: core: add function dev_fetch_sw_netstats for fetching
    pcpu_sw_netstats
  IB/hfi1: use new function dev_fetch_sw_netstats
  net: macsec: use new function dev_fetch_sw_netstats
  net: usb: qmi_wwan: use new function dev_fetch_sw_netstats
  net: usbnet: use new function dev_fetch_sw_netstats
  qtnfmac: use new function dev_fetch_sw_netstats
  net: bridge: use new function dev_fetch_sw_netstats
  net: dsa: use new function dev_fetch_sw_netstats
  iptunnel: use new function dev_fetch_sw_netstats
  mac80211: use new function dev_fetch_sw_netstats
  net: openvswitch: use new function dev_fetch_sw_netstats
  xfrm: use new function dev_fetch_sw_netstats

 drivers/infiniband/hw/hfi1/ipoib_main.c       | 34 +------------------
 drivers/net/macsec.c                          | 22 +-----------
 drivers/net/usb/qmi_wwan.c                    | 24 +------------
 drivers/net/usb/usbnet.c                      | 24 +------------
 drivers/net/wireless/quantenna/qtnfmac/core.c | 27 +--------------
 include/linux/netdevice.h                     |  2 ++
 net/bridge/br_device.c                        | 21 +-----------
 net/core/dev.c                                | 34 +++++++++++++++++++
 net/dsa/slave.c                               | 21 +-----------
 net/ipv4/ip_tunnel_core.c                     | 23 +------------
 net/mac80211/iface.c                          | 23 +------------
 net/openvswitch/vport-internal_dev.c          | 20 +----------
 net/xfrm/xfrm_interface.c                     | 22 +-----------
 13 files changed, 47 insertions(+), 250 deletions(-)

-- 
2.28.0




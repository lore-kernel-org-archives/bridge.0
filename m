Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0PRt/VgUMfU+Km7oQtNyegEwmqK7TcrIJ3oC/T2znis=;
 b=HqqXCZ+SdFe/gAHYE9t/D7bpvda+FpPaKEvItX1IoiJunT267+8UDApVkDk0p7/R1S
 KA35FvbBnxLGKJb5Oyz3hYCc7kzWtcAD9G+6wqoXHXO7PR2JXDDclMVf1jzzeUl4Rv/A
 Nyf22eCit7mLJKOLc3UrmCIjI22VH05KbJHaI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 20 Mar 2020 13:23:01 +0200
Message-Id: <20200320112303.81904-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/2] net: bridge: vlan options: nest the
	tunnel options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
After a discussion with Roopa about the new tunnel vlan option, she
suggested that we'll be adding more tunnel options and attributes, so
it'd be better to have them all grouped together under one main vlan
entry tunnel attribute instead of making them all main attributes. Since
the tunnel code was added in this net-next cycle and still hasn't been
released we can easily nest the BRIDGE_VLANDB_ENTRY_TUNNEL_ID attribute
in BRIDGE_VLANDB_ENTRY_TUNNEL_INFO and allow for any new tunnel
attributes to be added there. In addition one positive side-effect is
that we can remove the outside vlan info flag which controlled the
operation (setlink/dellink) and move it under a new nested attribute so
user-space can specify it explicitly.

Thus the vlan tunnel format becomes:
 [BRIDGE_VLANDB_ENTRY]
     [BRIDGE_VLANDB_ENTRY_TUNNEL_INFO]
         [BRIDGE_VLANDB_TINFO_ID]
         [BRIDGE_VLANDB_TINFO_CMD]
         ...

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: vlan options: nest the tunnel id into a tunnel info
    attribute
  net: bridge: vlan options: move the tunnel command to the nested
    attribute

 include/uapi/linux/if_bridge.h | 18 +++++++-
 net/bridge/br_vlan.c           |  2 +-
 net/bridge/br_vlan_options.c   | 76 +++++++++++++++++++++++++---------
 3 files changed, 74 insertions(+), 22 deletions(-)

-- 
2.25.1


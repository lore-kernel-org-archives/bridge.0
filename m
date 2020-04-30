Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=E0tSeJ
 Qs4F49nhcw9h7Mq+DKRjdkwObVDd0dqiIADY4=; b=R+TgxK9IVLXPfsFxwzjCn3
 pKROOzjEmF5C3sDu2C6mFoczn8Xw7i2LK3qILvRrY6V7/xjJifh9gf/kAwR+HiIK
 RaI1i6G/HOddiYK0L+ESRamP88qXgDePICiPyx/sM0rgxW72d9mRZHxl2j0QA5i+
 B+QngtHzhw3co11KaZ0KOe2n0kzGtyBsOW7X4XXVLY2mv+lTp/+BeZGcCtWq2Qz+
 J1XzGdPFraGjB+5tIU/GsimbkMt50kxTxMaWNrpGobdDO9OvAsr2l9NJy5SREL8e
 +POuOWARPQrv4yYxNHjVHLeen3yILL8IjLSFWVocjHS6ihiMyBWmy0CFDTKDvXfA
 ==
Date: Thu, 30 Apr 2020 13:55:51 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20200430105551.GA4068275@splinter>
References: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
Subject: Re: [Bridge] BUG: soft lockup while deleting tap interface from
 vlan aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

On Wed, Apr 29, 2020 at 10:52:35PM +0200, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> while running a stable vanilla kernel 4.19.115 i'm reproducably get this
> one:
> 
> watchdog: BUG: soft lockup - CPU#38 stuck for 22s! [bridge:3570653]
> 
> ...
> 
> Call
> Trace:nbp_vlan_delete+0x59/0xa0br_vlan_info+0x66/0xd0br_afspec+0x18c/0x1d0br_dellink+0x74/0xd0rtnl_bridge_dellink+0x110/0x220rtnetlink_rcv_msg+0x283/0x360

Nik, Stefan,

My theory is that 4K VLANs are deleted in a batch and preemption is
disabled (please confirm). For each VLAN the kernel needs to go over the
entire FDB and delete affected entries. If the FDB is very large or the
FDB lock is contended this can cause the kernel to loop for more than 20
seconds without calling schedule().

To reproduce I added mdelay(100) in br_fdb_delete_by_port() and ran
this:

ip link add name br10 up type bridge vlan_filtering 1
ip link add name dummy10 up type dummy
ip link set dev dummy10 master br10
bridge vlan add vid 1-4094 dev dummy10 master
bridge vlan del vid 1-4094 dev dummy10 master

Got a similar trace to Stefan's. Seems to be fixed by attached:

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a774e19c41bb..240e260e3461 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -615,6 +615,7 @@ int br_process_vlan_info(struct net_bridge *br,
                                               v - 1, rtm_cmd);
                                v_change_start = 0;
                        }
+                       cond_resched();
                }
                /* v_change_start is set only if the last/whole range changed */
                if (v_change_start)

WDYT?

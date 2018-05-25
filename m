Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=U7fCybMRioa8We+quXbrKrT6nFZFCwuQQGfNMkte6GM=;
	b=AOk9+Lqu5kXu7AxzBslAeg3zpGLYJHpLhTvx1kU7ZI76DpGDoS2RG7enD1D8wA4UsF
	6b2DIO/XOsXqEZYp54UeSbG1K9lhxRd9wYY/2jr0y7xTqi1uIl2vqyq50My2R/aabO/x
	bd5JS8WSsvBWcY82A0bnmXvqkkYTJyNjjV0Z8QApdO6Wcw60SCw8nrwblZOvDBExJJDL
	ufs6kRucrBqiZfpyjxoQBqg7tvY69nDLyfPu2n4CGzqViu0ZXz+J5PjNZOlTlGZR+kMD
	P+pBBIUca3xYppRr5i1ISH2Yp2bwPy/bWWT45CbEKy1b6CR0VBLjIwiFgILdmVuq94zc
	OTXg==
From: Florian Fainelli <f.fainelli@gmail.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com>
Message-ID: <1ea85ef2-0feb-dec0-ae25-68f4b42543b2@gmail.com>
Date: Thu, 24 May 2018 20:40:22 -0700
MIME-Version: 1.0
In-Reply-To: <61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net



On 05/24/2018 10:20 AM, Florian Fainelli wrote:
> Hi Petr,
> 
> On 05/24/2018 08:09 AM, Petr Machata wrote:
>> In commit 946a11e7408e ("mlxsw: spectrum_span: Allow bridge for gretap
>> mirror"), mlxsw got support for offloading mirror-to-gretap such that
>> the underlay packet path involves a bridge. In that case, the offload is
>> also influenced by PVID setting of said bridge. However, changes to VLAN
>> configuration of the bridge itself do not generate switchdev
>> notifications, so there's no mechanism to prod mlxsw to update the
>> offload when these settings change.
>>
>> In this patchset, the problem is resolved by distributing the switchdev
>> notification SWITCHDEV_OBJ_ID_PORT_VLAN also for configuration changes
>> on bridge VLANs. Since stacked devices distribute the notification to
>> lower devices, such event eventually reaches the driver, which can
>> determine whether it's a bridge or port VLAN by inspecting orig_dev.
>>
>> To keep things consistent, the newly-distributed notifications observe
>> the same protocol as the existing ones: dual prepare/commit, with
>> -EOPNOTSUPP indicating lack of support, even though there's currently
>> nothing to prepare for and nothing to support. Correspondingly, all
>> switchdev drivers have been updated to return -EOPNOTSUPP for bridge
>> VLAN notifications.
> 
> You seem to have approached the bridge changes a little differently from
> this series:
> 
> https://lists.linux-foundation.org/pipermail/bridge/2016-November/010112.html
> 
> Both have the same intent that by targeting the bridge device itself,
> you can propagate that through switchdev to the switch drivers, and in
> turn create configurations where for instance, you have:
> 
> - CPU/management port present in specific VLANs that is a subset or
> superset of the VLANs configured on front-panel ports
> - CPU/management port tagged/untagged in specific VLANs which can be a
> different setting from the front-panel ports
> 
> One problem we have in DSA at the moment is that we always add the CPU
> port to the VLANs configured to the front-panel port but we do this with
> the same attributes as the front panel ports! For instance, if you add
> Port 0 to VLAN1 untagged, the the CPU port also gets added to that
> VLAN1, also untagged. As long as there is just one VLAN untagged, this
> is not much of a problem. Now do this with another VLAN or another port,
> and the CPU can no longer differentiate the traffic from which VLAN it
> is coming from, no bueno.
> 
> I had specifically changed b53 to always add the CPU port as tagged,
> because that would always allow for differentiating traffic, but I would
> rather have the capability to configure that at the bridge layer, which
> you series seem to allow.
> 
> For the record, here is what the first commit in the series intended to
> let an user do:
> 
> The following happens now (assuming bridge master device is already
> created):
> 
> bridge vlan add vid 2 dev port0 pvid untagged
> 	-> port0 (e.g: switch port 0) gets programmed
> 	-> CPU port gets programmed
> bridge vlan add vid 2 dev br0 self
> 	-> CPU port gets programmed
> bridge vlan add vid 2 dev port0
> 	-> port0 (switch port 0) gets programmed
> 
> Are these use cases possible with your series? It seems to me like it is
> if we drop the netif_is_bridge_master() checks and resolve orig_dev as
> being a hint for the CPU/management port.

So I changed your code a little bit in net/dsa/port.c to verify what
would happen and so far, this looks good except that I am seeing more
programming events than I am expecting. The change I did is the following:

diff --git a/net/dsa/port.c b/net/dsa/port.c
index ed0595459df1..37385e491117 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -253,7 +253,7 @@ int dsa_port_vlan_add(struct dsa_port *dp,
        };

        if (netif_is_bridge_master(vlan->obj.orig_dev))
-               return -EOPNOTSUPP;
+               info.port = dp->cpu_dp->index;

        if (br_vlan_enabled(dp->bridge_dev))
                return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
@@ -271,7 +271,7 @@ int dsa_port_vlan_del(struct dsa_port *dp,
        };

        if (netif_is_bridge_master(vlan->obj.orig_dev))
-               return -EOPNOTSUPP;
+               info.port = dp->cpu_dp->index;

        if (br_vlan_enabled(dp->bridge_dev))
                return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);

And the commands above result in the following:

root@net-vm:~# bridge vlan add vid 2 dev lan1 pvid untagged
[  478.065728] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 0
vlan: 2, untagged
[  478.066440] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, untagged
[  478.067890] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged
[  478.068486] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged
root@net-vm:~# bridge vlan add vid 2 dev br0 self
[  507.931313] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged
[  507.931826] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged
root@net-vm:~# bridge vlan add vid 2 dev lan1
[  518.955814] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 0
vlan: 2, tagged
[  518.956454] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged
root@net-vm:~#

So commands #1 and #2 get too many events targeting the CPU port, if we
remove the following hunk:

diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index b93511726069..60ecc87bf6c0 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -212,7 +212,7 @@ static int dsa_switch_vlan_add(struct dsa_switch *ds,
        if (ds->index == info->sw_index)
                set_bit(info->port, members);
        for (port = 0; port < ds->num_ports; port++)
-               if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
+               if (dsa_is_dsa_port(ds, port))
                        set_bit(port, members);

        if (switchdev_trans_ph_prepare(trans))

Then we get the expected number of events for the ports:

root@net-vm:~# bridge vlan add vid 2 dev lan1 pvid untagged
[  111.906710] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 0
vlan: 2, untagged, pvid: 1
[  111.908988] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged, pvid: 0
root@net-vm:~# bridge vlan add vid 2 dev br0 self
[  121.829272] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 5
vlan: 2, tagged, pvid: 0
root@net-vm:~# bridge vlan add vid 2 dev lan1
[  133.224113] dsa-loop fixed-0:1f: dsa_loop_port_vlan_add: port: 0
vlan: 2, tagged, pvid: 0

Andrew, Vivien, if the following hunks get applied are we possibly
breaking mv88e6xxx? This is the use case that is really missing IMHO at
the moment in DSA: we cannot control the VLAN membership and attributes
of the CPU port(s), so either we make it always tagged in every VLAN
(not great), or we introduce the ability to target the CPU port which is
what Petr's patches + mine do.

Thanks a second time for reading me :)
-- 
Florian

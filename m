Message-ID: <4D41D3A4.7060705@candelatech.com>
Date: Thu, 27 Jan 2011 12:20:52 -0800
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
In-Reply-To: <AANLkTik9i930FMKv4rNajQ2v+ajkdViwFaqrUnw2hD=b@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------070700010807080205010808"
Subject: Re: [Bridge] Packet "leakage" between two bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arun Khan <knura9@gmail.com>
Cc: Linux Bridge <bridge@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--------------070700010807080205010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/27/2011 11:52 AM, Arun Khan wrote:
> Host OS/HW: Debian Squeeze (amd64), openSUSE 11.3 (amd64), 6GB RAM,
> Core2Quad 8600
>
> I am trying to create "virtual" networks using bridge, ethernet and
> tap interfaces in my desktop [1]
>
> The network topology that I want to simulate is as follows:
>
> Evaluate LiveCD distros (including GW/Firewall ISOs) using the Linux KVM.
>
> Using brctl and tunctl  I have the following setup (brctl show):
>
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.001cc09b9b54       no                  eth0
>                                                                             tap0
> br1             8000.7e45d3f813b4        no                  tap1
>                                                                             tap2
>
> br0 (192.168.1.69) (bridged to eth0) LAN has a DHCP server and it is
> the bridge to the "external" network whereas br1 is supposed to be the
> switch for LAN (isolated).
>
> Through the KVM, the Guest OS is presented two ethernet interfaces
> tap0 for the WAN ethernet port (tap0) and tap1 for the LAN for the
> ethernet port.
>
> The KVM command line for the "GW" VM is:
>
> kvm \
> -vga std \
> -m 256 \
> -boot d \
> -cdrom ${KVM_LIVE_CD} \
> -net nic,model=rtl8139,macaddr=${nic_mac_addr0} \
> -net tap,ifname=tap0,script=no,downscript=no \
> -net nic,model=e1000,macaddr=${nic_mac_addr1} \
> -net tap,ifname=tap1,script=no,downscript=no \
>
> Variable KVM_LIVE_CD points to the relevant ISO image.
>
> When I boot a LiveCD which acquires IP on *all*  the network
> interfaces via DHCP; in the Guest OS, I find that both network
> interfaces have been assigned IP numbers from the 192.168.1.0 network
> from the DHCP server.
>
> For the WAN port, it makes sense as br0 is connected to eth0 and the
> Guest OS acquires an IP address from the DHCP server.
>
> However, I did not expect the "LAN" port, in the Guest OS, to acquire
> and IP number from the same DHCP server.  As br1 does not connect to
> any physical interface (like eth0), I expect the second interface eth1
> (tap1 in Host OS) to not have any IP.
>
>> From the above, it appears that even though the two bridges are
> defined separately, essentially ethernet frames on either bridge are
> visible to both bridge.
>
> Is it possible to restrict ethernet traffic to it's respective bridge
> only?  I am really keen on finding a solution.  Any pointers /
> solutions would be highly appreciated.

I hit something similar that appeared due to connection tracking.  I got
my case working with the attached patch.  This was against some hacked
bridge code, so not 100% sure it will apply cleanly.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


--------------070700010807080205010808
Content-Type: text/plain;
 name="0001-bridge-Allow-disabling-all-ebtables-calls-on-a-bri.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-bridge-Allow-disabling-all-ebtables-calls-on-a-bri.patc";
 filename*1="h"

From 92cd3257583c453590c0a96a9da57b4b64f0bd54 Mon Sep 17 00:00:00 2001
From: Ben Greear <greearb@v-debian-lenny.candelatech.com>
Date: Tue, 14 Dec 2010 21:39:02 -0800
Subject: [PATCH] bridge:  Allow disabling all ebtables calls on a bridge.

This allows one to run one bridge in 'clean' mode and have
another one connected by a 'veth' pair do ebtables re-direct
and squid goodness.  Otherwise, there is some sort of conntracking
issue that messes things up.

ip link add name veth1 type veth peer name veth2
/sbin/ifconfig eth0 promisc 0.0.0.0 up
/sbin/ifconfig eth1 promisc 0.0.0.0 up
/sbin/ifconfig veth1 promisc 0.0.0.0 up
/sbin/ifconfig veth2 promisc 0.0.0.0 up
/usr/sbin/brctl addbr my
/usr/sbin/brctl addif my veth1
/usr/sbin/brctl addif my eth1
/usr/sbin/brctl addbr br0
/usr/sbin/brctl addif br0 eth0
/usr/sbin/brctl addif br0 veth2
/sbin/ifconfig my up
/sbin/ifconfig br0 up
/sbin/ifconfig br0 192.168.100.39 netmask 255.255.255.0 up
/sbin/route add default gw 192.168.100.1

echo 0 > /sys/class/net/my/bridge/nf_call_ebtables
echo 0 > /sys/class/net/my/bridge/nf_call_iptables
echo 0 > /sys/class/net/my/bridge/nf_call_ip6tables
echo 0 > /sys/class/net/my/bridge/nf_call_arptables

echo 0 > /proc/sys/net/bridge/bridge-nf-call-arptables
echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 0 > /proc/sys/net/bridge/bridge-nf-call-ip6tables

echo 1 > /sys/class/net/br0/bridge/nf_call_ebtables
echo 1 > /sys/class/net/br0/bridge/nf_call_iptables
echo 1  > /sys/class/net/br0/bridge/nf_call_ip6tables
echo 1 > /sys/class/net/br0/bridge/nf_call_arptables

/sbin/ebtables -t broute -A BROUTING -i br0 -p IPv4 --ip-protocol 6 \
    --ip-destination-port 80 -j redirect --redirect-target ACCEPT
/sbin/iptables -t nat -A PREROUTING -i br0 -p tcp --dport 80 -j \
   REDIRECT --to-port 3128

Signed-off-by: Ben Greear <greearb@v-debian-lenny.candelatech.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
---
:100644 100644 1255a2a... 1266419... M	net/bridge/br_forward.c
:100644 100644 c03d2c3... 9d8b93b... M	net/bridge/br_if.c
:100644 100644 826cd52... cbec50d... M	net/bridge/br_input.c
:100644 100644 eb5b256... 1f07775... M	net/bridge/br_multicast.c
:100644 100644 13cb5d0... fb34a42... M	net/bridge/br_private.h
:100644 100644 35cf270... 2653f32... M	net/bridge/br_stp_bpdu.c
:100644 100644 5c1e555... fa7ded3... M	net/bridge/br_sysfs_br.c
 net/bridge/br_forward.c   |   27 +++++++++++++++++++++------
 net/bridge/br_if.c        |    4 +++-
 net/bridge/br_input.c     |   30 ++++++++++++++++++++++++------
 net/bridge/br_multicast.c |    9 +++++++--
 net/bridge/br_private.h   |    1 +
 net/bridge/br_stp_bpdu.c  |    9 +++++++--
 net/bridge/br_sysfs_br.c  |   23 +++++++++++++++++++++++
 7 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 1255a2a..1266419 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -323,8 +323,13 @@ void printk_br_timers(void) {
 
 int br_forward_finish(struct sk_buff *skb)
 {
-	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_POST_ROUTING, skb, NULL, skb->dev,
-		       br_dev_queue_push_xmit);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	if (br_port_get_rcu(skb->dev)->br->nf_call_ebtables)
+		return NF_HOOK(NFPROTO_BRIDGE, NF_BR_POST_ROUTING, skb, NULL, skb->dev,
+			       br_dev_queue_push_xmit);
+	else
+#endif
+		return br_dev_queue_push_xmit(skb);
 
 }
 
@@ -342,8 +347,13 @@ static void __br_deliver(const struct net_bridge_port *to, struct sk_buff *skb)
 		return;
 	}
 
-	NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
-		br_forward_finish);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	if (br_port_get_rcu(skb->dev)->br->nf_call_ebtables)
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+			br_forward_finish);
+	else
+#endif
+		br_forward_finish(skb);
 }
 
 static void __br_forward(const struct net_bridge_port *to, struct sk_buff *skb)
@@ -638,8 +648,13 @@ after_ignore_check:
 		return; /* packet will get sent later */
 IGNORE:
 
-	NF_HOOK(NFPROTO_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
-		br_forward_finish);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	if (br_port_get_rcu(skb->dev)->br->nf_call_ebtables)
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_FORWARD, skb, indev, skb->dev,
+			br_forward_finish);
+	else
+#endif
+		br_forward_finish(skb);
 }
 
 /* Hold list lock while calling this, and delete the skb that
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c03d2c3..9d8b93b 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -217,7 +217,9 @@ static struct net_device *new_bridge_dev(struct net *net, const char *name)
 	br->topology_change = 0;
 	br->topology_change_detected = 0;
 	br->ageing_time = 300 * HZ;
-
+#ifdef CONFIG_BRIDGE_NETFILTER
+	br->nf_call_ebtables = 1;
+#endif
 	br_netfilter_rtable_init(br);
 
 	br_stp_timer_init(br);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 826cd52..cbec50d 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -35,8 +35,13 @@ static int br_pass_frame_up(struct sk_buff *skb)
 	indev = skb->dev;
 	skb->dev = brdev;
 
-	return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
-		       netif_receive_skb);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	if (br->nf_call_ebtables)
+		return NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, skb, indev, NULL,
+			       netif_receive_skb);
+	else
+#endif
+		return netif_receive_skb(skb);
 }
 
 /* note: already called with rcu_read_lock */
@@ -154,6 +159,7 @@ struct sk_buff *br_handle_frame(struct sk_buff *skb)
 	p = br_port_get_rcu(skb->dev);
 
 	if (unlikely(is_link_local(dest))) {
+		int rv;
 		/* Pause frames shouldn't be passed up by driver anyway */
 		if (skb->protocol == htons(ETH_P_PAUSE))
 			goto drop;
@@ -162,8 +168,15 @@ struct sk_buff *br_handle_frame(struct sk_buff *skb)
 		if (p->br->stp_enabled == BR_NO_STP && dest[5] == 0)
 			goto forward;
 
-		if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
-			    NULL, br_handle_local_finish))
+#ifdef CONFIG_BRIDGE_NETFILTER
+		if (p->br->nf_call_ebtables)
+			rv = NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, skb, skb->dev,
+				     NULL, br_handle_local_finish);
+		else
+#endif
+			rv = br_handle_local_finish(skb);
+
+		if (rv)
 			return NULL;	/* frame consumed by filter */
 		else
 			return skb;	/* continue processing */
@@ -183,8 +196,13 @@ forward:
 		if (!compare_ether_addr(p->br->dev->dev_addr, dest))
 			skb->pkt_type = PACKET_HOST;
 
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
-			br_handle_frame_finish);
+#ifdef CONFIG_BRIDGE_NETFILTER
+		if (p->br->nf_call_ebtables)
+			NF_HOOK(NFPROTO_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
+				br_handle_frame_finish);
+		else
+#endif
+			br_handle_frame_finish(skb);
 		break;
 	default:
 drop:
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index eb5b256..1f07775 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -811,8 +811,13 @@ static void __br_multicast_send_query(struct net_bridge *br,
 	if (port) {
 		__skb_push(skb, sizeof(struct ethhdr));
 		skb->dev = port->dev;
-		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
-			dev_queue_xmit);
+#ifdef CONFIG_BRIDGE_NETFILTER
+		if (br->nf_call_ebtables)
+			NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+				dev_queue_xmit);
+		else
+#endif
+			dev_queue_xmit(skb);
 	} else
 		netif_rx(skb);
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 13cb5d0..fb34a42 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -176,6 +176,7 @@ struct net_bridge
 	unsigned long			feature_mask;
 #ifdef CONFIG_BRIDGE_NETFILTER
 	struct rtable 			fake_rtable;
+	bool				nf_call_ebtables;
 	bool				nf_call_iptables;
 	bool				nf_call_ip6tables;
 	bool				nf_call_arptables;
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 35cf270..2653f32 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -50,8 +50,13 @@ static void br_send_bpdu(struct net_bridge_port *p,
 
 	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
 
-	NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
-		dev_queue_xmit);
+#ifdef CONFIG_BRIDGE_NETFILTER
+	if (p->br->nf_call_ebtables)
+		NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
+			dev_queue_xmit);
+	else
+#endif
+		dev_queue_xmit(skb);
 }
 
 static inline void br_set_ticks(unsigned char *dest, int j)
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index 5c1e555..fa7ded3 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -612,6 +612,28 @@ static DEVICE_ATTR(multicast_startup_query_interval, S_IRUGO | S_IWUSR,
 		   store_multicast_startup_query_interval);
 #endif
 #ifdef CONFIG_BRIDGE_NETFILTER
+static ssize_t show_nf_call_ebtables(
+	struct device *d, struct device_attribute *attr, char *buf)
+{
+	struct net_bridge *br = to_bridge(d);
+	return sprintf(buf, "%u\n", br->nf_call_ebtables);
+}
+
+static int set_nf_call_ebtables(struct net_bridge *br, unsigned long val)
+{
+	br->nf_call_ebtables = val ? true : false;
+	return 0;
+}
+
+static ssize_t store_nf_call_ebtables(
+	struct device *d, struct device_attribute *attr, const char *buf,
+	size_t len)
+{
+	return store_bridge_parm(d, buf, len, set_nf_call_ebtables);
+}
+static DEVICE_ATTR(nf_call_ebtables, S_IRUGO | S_IWUSR,
+		   show_nf_call_ebtables, store_nf_call_ebtables);
+
 static ssize_t show_nf_call_iptables(
 	struct device *d, struct device_attribute *attr, char *buf)
 {
@@ -713,6 +735,7 @@ static struct attribute *bridge_attrs[] = {
 	&dev_attr_multicast_startup_query_interval.attr,
 #endif
 #ifdef CONFIG_BRIDGE_NETFILTER
+	&dev_attr_nf_call_ebtables.attr,
 	&dev_attr_nf_call_iptables.attr,
 	&dev_attr_nf_call_ip6tables.attr,
 	&dev_attr_nf_call_arptables.attr,
-- 
1.6.2.5


--------------070700010807080205010808--

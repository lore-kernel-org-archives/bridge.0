From: Rajashekhar Mansanpally <raj@roinet.com>
Content-Type: text/plain
Message-Id: <1073921027.25629.21.camel@honeycomb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge Netfilter question
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Mon, 12 Jan 2004 15:23:58 -0000
To: bridge@lists.osdl.org

Hi guyz,
Looks like Bart Schuymer is busy. I will appreciate if anyone else can
help me.

I am using br_handle_frame_finish to implement my protocol which
encapusulates and also decapsulates just like VLAN does. I made changes
to br_netfilter.c similar to VLAN protocol and the IPTABLES seems to be
working. But my ebtables INPUT chain does not see the frame early
enough. ebtables INPUT chain is seeing frame after the decapsulation.

The remedy, Bart says:
> You should not add a new hook. What you need to do is register your
function 
> on the existing NF_BR_PRE_ROUTING hook, with a priority number lower
than 
> that of the ebtables nat PREROUTING chain (prio=NF_BR_PRI_NAT_SRC).
> See f.e. net/bridge/netfilter/ebtable_nat.c, where the ebtables nat
chains are 
> registered on the relevant netfilter hooks.

can I add the following:

{ { NULL, NULL }, br_handle_frame_finish, PF_BRIDGE, NF_BR_PRE_ROUTING,
           NF_BR_PRI_BRNF},

to ebtables_nat.c @ end of 'static struct nf_hook_ops ebt_ops_nat[] {' ?

Thanks in advance,
Raj



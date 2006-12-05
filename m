Date: Tue, 5 Dec 2006 18:13:17 +0100
From: Tino Keitel <tino.keitel@innominate.com>
Message-ID: <20061205171317.GB24251@tkeitel002.bln.innominate.local>
References: <20061205123729.GA24251@tkeitel002.bln.innominate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205123729.GA24251@tkeitel002.bln.innominate.local>
Subject: Re: [Bridge] Clarification regarding device matches in
	bridge-netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

On Tue, Dec 05, 2006 at 13:37:29 +0100, Tino Keitel wrote:
> Hi folks,
> 
> in 2.4 kernels, device matching for bridged packets was done with
> iptables -i/-o. Since 2.6, I was used to use -m physdev here.
> 
> In 2.6.18, This seems to be more complicated. At least the filter/INPUT
> chain now doesn't match with -m physdev --physdev-in anymore, but
> FORWARD and OUTPUT does. I also read the note that -m phydev is now
> deprecated for non-bridged traffic.
> 
> Does this mean that
> 
> 1. I have to use the physdev match for bridged traffic, e.g. FORWARD,
>    POSTROUTING, PREROUTING
> 
> 2. I have to use iptables -i in the INPUT chain and on PREROUTING
> 
> 3. I have to use the physdev match in the OUTPUT chain
> 
> 4. I have to distinguish between bridged and locally processed or
>    routed traffic in PREROUTING, since bridged traffic needs -m
>    physdev, whereas the other traffic need -i
> 
> 5. until now, outgoing traffic is always matched with -m physdev, but
>    this will change in the future. If the change is made, I'll have to
>    distinguish in the same way as for incoming traffic

Hi,

I'm quite puzzled.

A packet that is redirected from the bridge to be processed locally
isn't always matched with -i or -m physdev.

The bridge has 2 interfaces. For one interface, I have to use -i, for
the other interface, I have to use -m physdev. See the iptables output below.
As you can see, the second line with -m physdev matches.

0  0        tcp -- eth0+ * 0.0.0.0/0 0.0.0.0/0
1 60 ACCEPT tcp -- br0   * 0.0.0.0/0 0.0.0.0/0 tcp dpt:443 PHYSDEV match --physdev-in eth0+

The next lines are for a packet that comes in at the other bridge
interface:

1 60        tcp -- eth1+ * 0.0.0.0/0 0.0.0.0/0
0  0 ACCEPT tcp -- br0   * 0.0.0.0/0 0.0.0.0/0 tcp dpt:443 PHYSDEV match --physdev-in eth1+

As you can see, the -i eth1+ matches, -m physdev does not.

All rules are in a user defined chain that is referenced in the INPUT
chain. The kernel is still 2.6.18. Is there something wrong? If not,
how do I know if I have to use -i or -m physdev, without trial and
error?

Regards,
Tino

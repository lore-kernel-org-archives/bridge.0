Date: Tue, 5 Dec 2006 09:19:36 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061205091936.4dca40b3@freekitty>
In-Reply-To: <20061205123729.GA24251@tkeitel002.bln.innominate.local>
References: <20061205123729.GA24251@tkeitel002.bln.innominate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Tino Keitel <tino.keitel@innominate.com>
Cc: bridge@lists.osdl.org

On Tue, 5 Dec 2006 13:37:29 +0100
Tino Keitel <tino.keitel@innominate.com> wrote:

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
> 
> Regards,
> Tino
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 

Post netfilter questions to 
	netfilter@lists.netfilter.org
-- 
Stephen Hemminger <shemminger@osdl.org>

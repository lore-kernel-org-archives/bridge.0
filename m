From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] bridge netfilter question
Date: Thu, 25 Dec 2003 18:52:58 +0100
References: <1072285918.7736.38.camel@honeycomb>
In-Reply-To: <1072285918.7736.38.camel@honeycomb>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312251852.58330.bdschuym@pandora.be>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: raj@roinet.com, bridge@lists.osdl.org

On Wednesday 24 December 2003 18:12, Rajashekhar Mansanpally wrote:
> #ifdef CONFIG_NETFILTER
>         if (skb->nf_bridge)
>                 memcpy(skb->data - 16,
> skb->nf_bridge->hh, 16);
> #endif
>
> 1. What is 16 bytes here...? Ethernet hdr is just 14
> bytes

A memcpy of 16 bytes is faster.

> 2. Why the ethernet hdr is being overwritten with
> nf_bridge->hh? what is there in nf_bridge->hh?

This is needed for refragmented UDP packets.

> when is nf_bridge is actually assigned this content.

See br_netfilter.c.

cheers,
Bart

From: Rajashekhar Mansanpally <raj@roinet.com>
Content-Type: text/plain
Message-Id: <1072285918.7736.38.camel@honeycomb>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge netfilter question
Reply-To: raj@roinet.com
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
Date: Wed, 24 Dec 2003 17:12:09 -0000
To: bridge@lists.osdl.org

Hi,
I found this block of code in br_dev_queue_xmit() @
br_forward.c, after applying 'netfilter' patch for
2.4.21 kernel

Can someone explain what this block of code is doin?

#ifdef CONFIG_NETFILTER
        if (skb->nf_bridge)
                memcpy(skb->data - 16,
skb->nf_bridge->hh, 16);
#endif

1. What is 16 bytes here...? Ethernet hdr is just 14
bytes
2. Why the ethernet hdr is being overwritten with
nf_bridge->hh? what is there in nf_bridge->hh? and
when is nf_bridge is actually assigned this content.

-Raj


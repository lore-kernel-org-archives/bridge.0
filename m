Date: Mon, 21 Mar 2005 18:44:20 +0800
From: "Zheng Chuanbo" <zhengcb@netpower.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200503211838168.SM02616@zhengcb>
Subject: [Bridge] The problem of bridge+netfilter+nat
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@lists.osdl.org>

Hi,

I met a problem when using bridge with netfilter. The kernel version 
2.4.20, and the patch is bridge-nf-0.0.10-against-2.4.20.diff. 

Our firewall configuration is as follows,
eth3,eth4,eth5,eth6 configured as a bridge with an IP address 10.0.0.1.
The local net connect to the internet via the gateway 10.0.0.1 and SNAT 
is applied on the firewall. It worked but sometimes there are some 
problems. The bridge stopped resonse now and there. When checking the
log there were some messages as below,

Mar 21 13:48:04 NPFW br_netfilter: Argh!! br_nf_post_routing: bad mac.raw pointer.[eth6][Bridge_0]
Mar 21 13:48:04 NPFW br_netfilter: Argh!! br_nf_post_routing: bad mac.raw pointer.[eth5][Bridge_0]
Mar 21 13:48:04 NPFW br_netfilter: Argh!! br_nf_post_routing: bad mac.raw pointer.[eth4][Bridge_0]
Mar 21 13:48:04 NPFW br_netfilter: Argh!! br_nf_post_routing: bad mac.raw pointer.[eth3][Bridge_0]

I checked the code, it is caused by some certain types of packets.
         
        /* Be very paranoid.  */
        if (skb->mac.raw < skb->head || skb->mac.raw + ETH_HLEN > skb->data) {
                printk(KERN_CRIT "br_netfilter: Argh!! br_nf_post_routing: "
                                 "bad mac.raw pointer."); 
                if (skb->dev != NULL) {
                        printk("[%s]", skb->dev->name);
                        if (has_bridge_parent(skb->dev))
                                printk("[%s]", bridge_parent(skb->dev)->name);
                }       
                printk("\n");
                return NF_ACCEPT;               
        }

And in the new bridge-nf version it is annouced this sould not happen anymore.
I think I should upgrade the kernel. But I'm curious on the problem and I wish
I could know what kind of packets caused such a problem. 

Thanks for help. Please cc.

Regards,

Zheng chuanbo          
zhengcb@netpower.com.cn


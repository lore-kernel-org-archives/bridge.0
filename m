Message-ID: <85c88fd30805070546m6b5c22acu62c121fe8e5ed1d2@mail.gmail.com>
Date: Wed, 7 May 2008 14:46:59 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_JEFFROY?=" <sebastien.jeffroy.cxr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_8512_27211981.1210164419804"
Subject: [Bridge] br_send_bpdu and br_log_state PATCH
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

------=_Part_8512_27211981.1210164419804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,
1) I modified br_send_bpdu() function.
I use an hardware switch that need to add 4 bytes after the DA/SA MAC
address. So it's a special header.
I used p->dev->hard_header() instead of llc_mac_hdr_init() which fills
default ethernet header (14 bytes : DA+SA+Len/Type)
My bridge code is based on kernel 2.6.17.8

2) I also added ioctl to device in br_log_state to inform the network device
driver that port state has changed. This is useful if you need to modify
hardware registers.
I used this ID for ioctls : *SIOCDEVPRIVATE + 16
*Maybe it can be a good idea to define a standard ioctl for this ??


*Code 1)*

static void br_send_bpdu(struct net_bridge_port *p,
              const unsigned char *data, int length)
{
    struct sk_buff *skb;
*    int extra_header_len = p->dev->hard_header_len - ETH_HLEN;
*
    if (!p->br->stp_enabled)
        return;

    skb = dev_alloc_skb(length+LLC_RESERVE*+extra_header_len*);
    if (!skb)
        return;

*    // Reserve area for extra header info
    if (extra_header_len)
        skb_reserve(skb, extra_header_len);
*
    skb->dev = p->dev;
    skb->protocol = htons(ETH_P_802_2);

    skb_reserve(skb, LLC_RESERVE);
    memcpy(__skb_put(skb, length), data, length);

    llc_pdu_header_init(skb, LLC_PDU_TYPE_U, LLC_SAP_BSPAN,
                LLC_SAP_BSPAN, LLC_PDU_CMD);
    llc_pdu_init_as_ui_cmd(skb);

*    // Check pointers and fill header
    if (p->dev!=NULL && p->dev->hard_header!=NULL &&
p->dev->hard_header_len!=ETH_HLEN)
    {
        // LLC_RESERVE can be 3 or 4 bytes !
        p->dev->hard_header(skb, p->dev, ETH_P_802_3,
                            p->br->group_addr, p->dev->dev_addr, skb->len);
    }
    else
*    {    // deafault ethernet header
        llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
    }

    NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb->dev,
        dev_queue_xmit);
}


*Code 2*
void br_log_state(const struct net_bridge_port *p)
{
    pr_info("%s: port %d(%s) entering %s state\n",
        p->br->dev->name, p->port_no, p->dev->name,
        br_port_state_names[p->state]);

*    p->dev->do_ioctl(    p->dev,     // network device
                        (struct ifreq*)p,    // data (struct net_bridge)
                        SIOCDEVPRIVATE + 16);    // command ID
*}

------=_Part_8512_27211981.1210164419804
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br>1) I modified br_send_bpdu() function.<br>I use an hardware switch that need to add 4 bytes after the DA/SA MAC address. So it&#39;s a special header.<br>I used p-&gt;dev-&gt;hard_header() instead of llc_mac_hdr_init() which fills default ethernet header (14 bytes : DA+SA+Len/Type)<br>
My bridge code is based on kernel <a href="http://2.6.17.8">2.6.17.8</a><br><br>2) I also added ioctl to device in br_log_state to inform the network device driver that port state has changed. This is useful if you need to modify hardware registers.<br>
I used this ID for ioctls : <b>SIOCDEVPRIVATE + 16<br></b>Maybe it can be a good idea to define a standard ioctl for this ??<br><br><br><u><b>Code 1)</b></u><br><br>static void br_send_bpdu(struct net_bridge_port *p,<br>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;const unsigned char *data, int length)<br>
{<br>&nbsp;&nbsp;&nbsp; struct sk_buff *skb;<br><b>&nbsp;&nbsp;&nbsp; int extra_header_len = p-&gt;dev-&gt;hard_header_len - ETH_HLEN;<br></b><br>&nbsp;&nbsp;&nbsp; if (!p-&gt;br-&gt;stp_enabled)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br><br>&nbsp;&nbsp;&nbsp; skb = dev_alloc_skb(length+LLC_RESERVE<b>+extra_header_len</b>);<br>
&nbsp;&nbsp;&nbsp; if (!skb)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br><br><b>&nbsp;&nbsp;&nbsp; // Reserve area for extra header info<br>&nbsp;&nbsp;&nbsp; if (extra_header_len)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; skb_reserve(skb, extra_header_len);<br></b><br>&nbsp;&nbsp;&nbsp; skb-&gt;dev = p-&gt;dev;<br>&nbsp;&nbsp;&nbsp; skb-&gt;protocol = htons(ETH_P_802_2);<br>
<br>&nbsp;&nbsp;&nbsp; skb_reserve(skb, LLC_RESERVE);<br>&nbsp;&nbsp;&nbsp; memcpy(__skb_put(skb, length), data, length);<br><br>&nbsp;&nbsp;&nbsp; llc_pdu_header_init(skb, LLC_PDU_TYPE_U, LLC_SAP_BSPAN,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; LLC_SAP_BSPAN, LLC_PDU_CMD);<br>&nbsp;&nbsp;&nbsp; llc_pdu_init_as_ui_cmd(skb);<br>
<br><b>&nbsp;&nbsp;&nbsp; // Check pointers and fill header<br>&nbsp;&nbsp;&nbsp; if (p-&gt;dev!=NULL &amp;&amp; p-&gt;dev-&gt;hard_header!=NULL &amp;&amp; p-&gt;dev-&gt;hard_header_len!=ETH_HLEN)<br>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // LLC_RESERVE can be 3 or 4 bytes !<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; p-&gt;dev-&gt;hard_header(skb, p-&gt;dev, ETH_P_802_3,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; p-&gt;br-&gt;group_addr, p-&gt;dev-&gt;dev_addr, skb-&gt;len);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; else<br></b>&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp; // deafault ethernet header<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; llc_mac_hdr_init(skb, p-&gt;dev-&gt;dev_addr, p-&gt;br-&gt;group_addr);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; NF_HOOK(PF_BRIDGE, NF_BR_LOCAL_OUT, skb, NULL, skb-&gt;dev,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_queue_xmit);<br>}<br><br><br><b><u>Code 2</u></b><br>
void br_log_state(const struct net_bridge_port *p)<br>{<br>&nbsp;&nbsp;&nbsp; pr_info(&quot;%s: port %d(%s) entering %s state\n&quot;,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; p-&gt;br-&gt;dev-&gt;name, p-&gt;port_no, p-&gt;dev-&gt;name, <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; br_port_state_names[p-&gt;state]);<br>
<br><b>&nbsp;&nbsp;&nbsp; p-&gt;dev-&gt;do_ioctl(&nbsp;&nbsp;&nbsp; p-&gt;dev, &nbsp;&nbsp;&nbsp; // network device<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (struct ifreq*)p,&nbsp;&nbsp;&nbsp; // data (struct net_bridge)<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; SIOCDEVPRIVATE + 16);&nbsp;&nbsp;&nbsp; // command ID<br></b>}<br>

------=_Part_8512_27211981.1210164419804--

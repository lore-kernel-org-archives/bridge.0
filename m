Return-Path: <brandon.carpenter@cypherpath.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cypherpath.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=N950m25Rty1j6JpGhNGRc504nbbz2j4mFznwzNXLVJw=;
	b=Uv2s5jd1qTDq9ZV4OGKfuhWUl/nqNIi8HFnQ0mVl3dNpbX5LCu6Dl7vR7UhWyeHDP/
	YvY2+XEtnDajxTRdu54aXJEjFMrIoc/kpac3Rm8fYbN5ppi3LZ45WnHwCcfhYL8oi4ge
	H0u6vS8B963FT7ewxYZLWV1DjCQxZh8GLu05A=
MIME-Version: 1.0
In-Reply-To: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
References: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Wed, 29 Nov 2017 14:01:11 -0800
Message-ID: <CAPpVWGtgf1cLBq0fyXKbZnzAgzvoX2mm3sLYm5QS7us5H-0XKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] Sending 802.1Q packets using AF_PACKET socket on
 filtered bridge forwards with wrong MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

I narrowed the search to a memmove() called from
skb_reorder_vlan_header() in net/core/skbuff.c.

>     memmove(skb->data - ETH_HLEN, skb->data - skb->mac_len - VLAN_HLEN,
>        2 * ETH_ALEN);

Calling skb_reset_mac_len() after skb_reset_mac_header() before
calling br_allowed_ingress() in net/bridge/br_device.c fixes the
problem.

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index af5b8c87f590..e10131e2f68f 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -58,6 +58,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct
net_device *dev)
        BR_INPUT_SKB_CB(skb)->brdev = dev;

        skb_reset_mac_header(skb);
+       skb_reset_mac_len(skb);
        eth = eth_hdr(skb);
        skb_pull(skb, ETH_HLEN);


I'll put together an official patch  and submit it. Should I use
another email account? Are my emails being ignored because of that
stupid disclaimer my employer attaches to my messages (outside my
control)?

Brandon

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

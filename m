Return-Path: <brandon.carpenter@cypherpath.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cypherpath.com; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=+rGybuALhI8HmsojNKe43pPq5P7WaBnAfCX98YNV2Ko=;
	b=Gg1bMiJOPcYZP9AawlOQ1/wCFvTPCLgJMrK8UrwctvimC2ZM7hoPwiQucene7pOwor
	EpO+K46es6w/KrgFXBQA0nnbz8792aEcIjLvNQOVC36suZzfUhZzovHvS12L/y+ZKVKZ
	yVCd5lXdXNA0QFmjPyUdygXb/GlvEidig+540=
MIME-Version: 1.0
In-Reply-To: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
References: <CAPpVWGuVsUP-4Ty7db4DQueL23yjPBMPG4+1Ui+OBTjfUHmVVg@mail.gmail.com>
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 28 Nov 2017 15:37:40 -0800
Message-ID: <CAPpVWGvchrhyBd2MaBG4DhwWSsbNYRwdtVE31TLswHdPODzq3A@mail.gmail.com>
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

I tracked down the function responsible for changing the MAC header.
It is skb_vlan_untag() called from __allowed_ingress() in
net/bridge/br_vlan.c. Before skb_vlan_untag() is called, the MAC
headers are perfect and afterward they are altered as previously
described. I'll continue digging into that function, but if any of you
have insight into what skb_vlan_untag() does and why it might alter
the MAC header the way it does in this special case, I would
appreciate the help.

Thanks,

Brandon

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

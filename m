Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IsWWcPyBf3Yi34lCJhNXBqNSjABC9oJnrYvhguJN/qE=;
 b=FoFsf33IZOWzsyNS7fdSHYnzIKST5V6Kudqlt2JufrGEns68j7i4T1e0+7Km2xoipc
 UQSwhGUlbG+/eOdXXYMgJFqno/85I46tSTjPt61ll43iEYRcdxTRQOcHfVhY3ENf5Bv5
 3JeSo0V8XqdhlbYuaNXG2DKYfM1QYlQZeOb4I=
References: <08a2e28b-fcf5-b26c-da75-97df67f51c7c@cumulusnetworks.com>
 <20200224130715.1446935-1-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <83cadec7-d659-cf2a-c0c0-a85d2f6503bc@cumulusnetworks.com>
Date: Mon, 24 Feb 2020 17:33:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200224130715.1446935-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix stale eth hdr pointer in
	br_dev_xmit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: syzbot+18c8b623c66fc198c493@syzkaller.appspotmail.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 24/02/2020 15:07, Nikolay Aleksandrov wrote:
> In br_dev_xmit() we perform vlan filtering in br_allowed_ingress() but
> if the packet has the vlan header inside (e.g. bridge with disabled
> tx-vlan-offload) then the vlan filtering code will use skb_vlan_untag()
> to extract the vid before filtering which in turn calls pskb_may_pull()
> and we may end up with a stale eth pointer. Moreover the cached eth header
> pointer will generally be wrong after that operation. Remove the eth header
> caching and just use eth_hdr() directly, the compiler does the right thing
> and calculates it only once so we don't lose anything.
> 
> Reported-by: syzbot+18c8b623c66fc198c493@syzkaller.appspotmail.com
> Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> ---
>  net/bridge/br_device.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Funny but this might turn out to be a totally unrelated bug to the one reported by syzbot.
I just noticed it's saying uninit instead of use-after-free. I'm now building the
whole syz environment mentioned in the report to check it out.
That being said - the bug that I'm fixing here exists, we just might have to drop the
Reported-by: tag if it turns out the uninit bug is a different one. :)

I'll report back when I'm able to reproduce the syz uninit bug.


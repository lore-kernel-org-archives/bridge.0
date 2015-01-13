Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=ZQrzFbGcOk7uwUJbGnhZvrD+/MCMcV8NpAvwrE4+Whs=;
	b=Fsqjdh53NFOL2lEX9Fz9IzhBCwCv5oZzcCT6Cn4cchFi3FvXvw4WxItGr94zgRBIAy
	gDysqAr1B35Tltmz876d5X6jqcOOvhgDt9gGERpG/Msjp+zYt2GPY9BXNKXnnGGhWGHM
	zERdNNSCIeGO3Mi0MPPwcOoKLIsEiagSM7I+frWze3OWozI45tpiY5H+u+x3R2BTQXJd
	rK138dDpVsFneOtW8goKWHel8hgXGH2gZyK8PRjtse1y3ZmtIXLxtv/SIxRRnTpxkIOo
	aHnHjWWzmnoTXIX41/swb+adADl2D0O9lntXzBrBVb0yelSTwmblNOKHLJnxr7kIh5BN
	3SEA==
Message-ID: <54B58AAC.7090001@gmail.com>
Date: Tue, 13 Jan 2015 14:14:20 -0700
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
References: <56868207.rHBDZL3pbk@wuerfel>	<CAHA+R7NfZMRMJ2=pq-VYU_FRdcCheAYu9OW6Hj9fwB0mcT7Xng@mail.gmail.com>
	<20150113.155740.1237959632603319909.davem@davemloft.net>
In-Reply-To: <20150113.155740.1237959632603319909.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: only provide proxy ARP when
	CONFIG_INET is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, cwang@twopensource.com, arnd@arndb.de
Cc: netdev@vger.kernel.org, kyeyoonp@codeaurora.org, bridge@lists.linux-foundation.org

On 1/13/15 1:57 PM, David Miller wrote:
> From: Cong Wang <cwang@twopensource.com>
> Date: Tue, 13 Jan 2015 11:25:45 -0800
>
>> On Tue, Jan 13, 2015 at 6:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> When IPV4 support is disabled, we cannot call arp_send from
>>> the bridge code, which would result in a kernel link error:
>>>
>>> net/built-in.o: In function `br_handle_frame_finish':
>>> :(.text+0x59914): undefined reference to `arp_send'
>>> :(.text+0x59a50): undefined reference to `arp_tbl'
>>>
>>> This makes the newly added proxy ARP support in the bridge
>>> code depend on the CONFIG_INET symbol and lets the compiler
>>> optimize the code out to avoid the link error.
>>>
>>
>> Not sure how much sense to make CONFIG_BRIDGE depend
>> on CONFIG_INET, at least CONFIG_BONDING does.
>
> It depends upon whether we want to provide and consider
> as a valid configuration bridging without INET.  Probably
> we do.

Rather than connect CONFIG_BRIDGE to CONFIG_INET, why not make 
br_do_proxy_arp (and setting BR_PROXYARP flag) a no-op if CONFIG_INET is 
not set?

#ifdef CONFIG_INET
#else
static inline void br_do_proxy_arp(...args...)
{
}
#endif

That covers both arp_tbl and arp_send.

David


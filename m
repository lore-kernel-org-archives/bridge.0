Return-Path: <prvs=492393ccd=imrep@amazon.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1424945973; x=1456481973;
	h=message-id:date:from:mime-version:to:cc:subject:
	references:in-reply-to:content-transfer-encoding;
	bh=myVnx8nko7SqB8/yHI7r4UI6eryWDkC+62+yKRJt01E=;
	b=OLtCNRcETMR3qCzu8Y7kGxwAnvr8Ru3evDwn9AukWwSnRNmXgDWaaiDx
	KEQYccW5MkSw2fvxPw4rcb5H4gPqygF1KTOz182v2N9zuMSmjsLNPDqBt
	dbzI+mSeBamfsuZ2PGhaFeBU4o9SoJqCW08WRMUPH15oqNTTfRZ7mXIXh Y=;
Message-ID: <54EEF32D.2010202@amazon.de>
Date: Thu, 26 Feb 2015 11:19:25 +0100
From: Imre Palik <imrep@amazon.de>
MIME-Version: 1.0
References: <1424705163-13428-1-git-send-email-imrep.amz@gmail.com>
	<20150223160619.GF24297@breakpoint.cc>
In-Reply-To: <20150223160619.GF24297@breakpoint.cc>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v2] bridge: make it possible for packets to
 traverse the bridge without hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>, Imre Palik <imrep.amz@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>, "David S. Miller" <davem@davemloft.net>

On 02/23/15 17:06, Florian Westphal wrote:
> Imre Palik <imrep.amz@gmail.com> wrote:
>> The netfilter code is made with flexibility instead of performance in mind.
>> So when all we want is to pass packets between different interfaces, the
>> performance penalty of hitting netfilter code can be considerable, even when
>> all the firewalling is disabled for the bridge.
>>
>> This change makes it possible to disable netfilter on a per bridge basis.
>> In the case interesting to us, this can lead to more than 15% speedup
>> compared to the case when only bridge-iptables is disabled.
> 
> I wonder what the speed difference is between no-rules (i.e., we hit jump label
> in NF_HOOK), one single (ebtables) accept-all rule, and this patch, for
> the call_nf==false case.

ebtables is completely empty:

# ebtables -L
Bridge table: filter

Bridge chain: INPUT, entries: 0, policy: ACCEPT

Bridge chain: FORWARD, entries: 0, policy: ACCEPT

Bridge chain: OUTPUT, entries: 0, policy: ACCEPT


on some bridges I have iptables rules, but on the critical bridges I am running with iptables disabled.

> I guess your 15% speedup figure is coming from ebtables' O(n) rule
> evaluation overhead?  If yes, how many rules are we talking about?

If you are looking for peculiarities in my setup then here they are:
I am on 4k pages, and perf is not working :-(
(I am trying to fix those too, but that is far from being a low hanging fruit.)
So my guess would be that the packet pipeline doesn't fit in the cache/tlb

> Iff thats true, then the 'better' (I know, it won't help you) solution
> would be to use nftables bridgeport-based verdict maps...
> 
> If thats still too much overhead, then we clearly need to do *something*...
> 
> Thanks,
> Florian
> 


Return-Path: <imrep.amz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=srQKnjbGkHsYQe3r9GNHIaSFPE6MGKSEng0QVR4jf/4=;
	b=O3rR037W+pwA7UlPLsoqzOsbr4+C/Qaus82GVhzle4VIaHqIL0JmYC/YKqddajaxfU
	TGaCP4h7rhFAvaXavXpsY6vItEd0kw+phu+GObicTZ89OYXuKGzs6naYroekvOCRMe5g
	x+isDMXOpSc47niqg1Ph+A734bRauGk/ggZO4tPjgAs6SfQ494fq80u3dFVLslsOpstt
	yQwTGRQVz8dMT6VGIAuGj3iPGSalVczwVPenyXaUioGM3eMh9qsf9KUjuFEQw1nrKuXl
	Vb6P9LXD/0hS38XhmSPxBhZEICJ8Qx8Zk3FnK3yCuH/Mrse2ZAjcx6YJyp8UlrQyG5AJ
	E0Ig==
Message-ID: <54EB4626.4050703@gmail.com>
Date: Mon, 23 Feb 2015 16:24:22 +0100
From: Imre Palik <imrep.amz@gmail.com>
MIME-Version: 1.0
References: <1423560744-19011-1-git-send-email-imrep.amz@gmail.com>
	<20150211.142936.951620487173949333.davem@davemloft.net>
	<54DE2174.6040001@gmail.com> <20150213163703.GC15141@breakpoint.cc>
	<54DE3851.7000206@gmail.com> <20150213190330.GD15141@breakpoint.cc>
In-Reply-To: <20150213190330.GD15141@breakpoint.cc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: make it possible for packets to
 traverse the bridge withour hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: imrep@amazon.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, aliguori@amazon.com, David Miller <davem@davemloft.net>

On 02/13/15 20:03, Florian Westphal wrote:
> Imre Palik <imrep.amz@gmail.com> wrote:
>> The trouble is that there are some bridges (with low traffic) where I need netfilter, and some other bridges (carrying lots of traffic), where I don't.  Being able to set things up on a per bridge basis is a powerful thing.
>>
>> I only implemented the global switch because the iptables and arptables support also have one.  If this is what bugs people here, I can remove it, and resubmit.
> 
> I see.  But I agree with David, accepting such patch would pave way
> for all kinds of ugly hacks.
> 
> It seems that technically the best solution would be to allow attaching
> filter rules to devices, but alas, netfilter doesn't support that.
> 
> Alternatively, you patch *might* be ok iff you can get rid of the extra
> userspace-visible configuration knobs, we already have way too many of
> these.

The sysctl can be removed.  But I need some means to switch it off for a given bridge, so I kept the sysfs interface.
If there is a more preferred way to do it, then please let me know.

> You'll also have to figure out how to avoid any run-time dependency on
> br_netfilter module from the bridge core.
> 
> If you can do this, you might be able to get similar effect as your patch
> by replacing
> 
> NF_HOOK with NF_HOOK_COND(..., !(br->flags & NO_NETFILTER))
> 
> or something like this.

This works nicely for the NFPROTO_BRIDGE, NF_BR_PRE_ROUTING case.  Thanks for the idea.
But for the NFPROTO_BRIDGE, NF_BR_FORWARD case the resulting code would be more ugly,
because of the chaining of the entries.

> I don't know how invasive this would be, though.

I will post the cleaned up version in a sec.
It looks way better.   I hope it will be enough ...

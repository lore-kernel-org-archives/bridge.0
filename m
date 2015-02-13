Return-Path: <imrep.amz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=0BEUAKpO4r4dpitgrbePpHjQZivhwy86oEbXVrEL87s=;
	b=ExcB7Y+ljaMjdKrgWJdPSBaErMShVX4/uDaaFDWxLMrYFRw0XaJsTAj/Upibz0rqgD
	xdfKnR1TkIYlJFNtHPJVNXNQNMiRhiX4hj9c3AVgMf0mfQPnfTf9LX6+m4cycZvm6Dbi
	wUvVKjmde2HFEcss69rhWRsV43C5bkTIyPvYZoriPECEmsRz8MxGAEW2DpWY3IsYepBQ
	9lXQ3i7ihsvsZo5XwN71hwoZ4fWPYlB5pnf82vEE804IujdPHTDMTRc8+AroorAL6ZFx
	9qf0o4w9cOVsv1j8Y+q4V8zX3iTa8D692iQlngHQpKusD8I0u76C+E8O4+iyQ7M3eH1t
	CkIg==
Message-ID: <54DE3851.7000206@gmail.com>
Date: Fri, 13 Feb 2015 18:45:53 +0100
From: Imre Palik <imrep.amz@gmail.com>
MIME-Version: 1.0
References: <1423560744-19011-1-git-send-email-imrep.amz@gmail.com>
	<20150211.142936.951620487173949333.davem@davemloft.net>
	<54DE2174.6040001@gmail.com> <20150213163703.GC15141@breakpoint.cc>
In-Reply-To: <20150213163703.GC15141@breakpoint.cc>
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

On 02/13/15 17:37, Florian Westphal wrote:
> Imre Palik <imrep.amz@gmail.com> wrote:
>> On 02/11/15 23:29, David Miller wrote:
>>> If I apply this, someone is going to try to submit a patch for every
>>> damn protocol layer to add a stupid hack like this.
>>
>> Actually this is one of those patches.  There is already a "stupid hack like this" for iptables and arptables.  (Implemented before git history, and giving me 10% speedup.  Many thanks, whoever did it.)
>>
>> I also searched various LKML archives, and it seems the existing "stupid hacks" for iptables and arptables haven't resulted in any related patch submission in the last ten years.  (Or my google-fu is weak.)
>>
>> Moreover, I cannot imagine any other reasonable on/off switch for bridge-netfilter than these three.  Of course, my imagination might be lacking there.
> 
> Why do you load the bridge netfilter module if you don't want it?
> Loading it registers the internal hooks for the call-ip(6)tables and
> sabotage hooks with NF_BRIDGE protocol so most of the NF_HOOK(NF_BRIDGE, ...
> calls become active.
> 

The trouble is that there are some bridges (with low traffic) where I need netfilter, and some other bridges (carrying lots of traffic), where I don't.  Being able to set things up on a per bridge basis is a powerful thing.

I only implemented the global switch because the iptables and arptables support also have one.  If this is what bugs people here, I can remove it, and resubmit.

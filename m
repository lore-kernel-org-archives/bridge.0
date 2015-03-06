Return-Path: <imrep.amz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=clzQ8zH/qteNY2ziXnDhyRswhQ1gBjGCdVLBcPyXWmI=;
	b=LI515JRy8F1D5qm8g67FjIy0mN9St968bj+slMm282EUM3PlMTYXCh6f6O53JF0QcU
	8jwlBbSgZduFrARzaZSMXtd1A1fw/7Hj5wH8NC2NJqBeXJKO/qngGOFApEzdU8t7H1/0
	9TdKcEwibgcbI7EUa9fCbkQ/1AUg4P048pXbGgZxRE5rPhuXIJ+cXZK4j9BFmjH27o6/
	xxaHaB6WFf50H0Xn64GazpjXBoG4uxbE8dtg6nRt4ON0zNdQsn39UwgqjPBNptud33aw
	9aMbYaja+mGaYPNzXh/W/qo6CSjs01H2txk32YyOfm3rZDaK0wfyu5qDrS4zgt4MwQhU
	3fOg==
Message-ID: <54F982B5.90108@gmail.com>
Date: Fri, 06 Mar 2015 11:34:29 +0100
From: Imre Palik <imrep.amz@gmail.com>
MIME-Version: 1.0
References: <1424705163-13428-1-git-send-email-imrep.amz@gmail.com>	<20150223160619.GF24297@breakpoint.cc>	<54EEF32D.2010202@amazon.de>
	<20150226.113431.238255529591339000.davem@davemloft.net>
In-Reply-To: <20150226.113431.238255529591339000.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
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
To: David Miller <davem@davemloft.net>, imrep@amazon.de
Cc: nbd@openwrt.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, aliguori@amazon.com

On 02/26/15 17:34, David Miller wrote:
> From: Imre Palik <imrep@amazon.de>
> Date: Thu, 26 Feb 2015 11:19:25 +0100
> 
>> If you are looking for peculiarities in my setup then here they are:
>> I am on 4k pages, and perf is not working :-(
>> (I am trying to fix those too, but that is far from being a low hanging fruit.)
>> So my guess would be that the packet pipeline doesn't fit in the cache/tlb
> 
> Pure specualtion until you can actually use perf to measure these
> things.
> 
> And I don't want to apply patches which were designed based upon
> pure speculation.
> 

I did performance measurements in the following way:

Removed those pieces of the packet pipeline that I don't necessarily need one-by-one.  Then measured their effect on small packet performance.

This was the only part that produced considerable effect.

The pure speculation was about why the effect is more than 15% increase in packet throughput, although the code path avoided contains way less code than 15% of the packet pipeline.  It seems, Felix Fietkau profiled similar changes, and found my guess well founded.

Now could anybody explain me what else is wrong with my patch?  I run out of ideas what to improve.

Thanks

Imre

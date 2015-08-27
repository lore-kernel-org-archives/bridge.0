Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=YBL8RTl7wbpirBloRXMmbAg6UzwqHsaATJaKZ6ZfcjM=;
	b=eEzkgqw1+lmel9wgQxgyG/Wwz5EZXx3rolQUUpbA1OGIFVjfCclQO9KbL+zI7QzsxJ
	jAnxbNrdSLfdDU1YkUiXuX7gCDx6x4CdtjgPJRjw6A0HUt5aomjvkmlbPBKw3zK03M7A
	3HYnnZuurQ/63cJzKSi3AW79qVrIjbDZTuxXo=
Message-ID: <55DE98AF.8000503@cumulusnetworks.com>
Date: Wed, 26 Aug 2015 21:57:19 -0700
From: roopa <roopa@cumulusnetworks.com>
MIME-Version: 1.0
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>
	<20150825.194222.390859854071446877.davem@davemloft.net>
	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
	<20150825.230641.773630246486190390.davem@davemloft.net>
	<AB16F445-DCA7-437E-B6E1-B70FDC63E55A@cumulusnetworks.com>
In-Reply-To: <AB16F445-DCA7-437E-B6E1-B70FDC63E55A@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: vlan: allow to suppress
 local mac install for all vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, wkok@cumulusnetworks.com, David Miller <davem@davemloft.net>

On 8/26/15, 4:33 AM, Nikolay Aleksandrov wrote:
>> On Aug 25, 2015, at 11:06 PM, David Miller <davem@davemloft.net> wrote:
>>
>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> Date: Tue, 25 Aug 2015 22:28:16 -0700
>>
>>> Certainly, that should be done and I will look into it, but the
>>> essence of this patch is a bit different. The problem here is not
>>> the size of the fdb entries, it’s more the number of them - having
>>> 96000 entries (even if they were 1 byte ones) is just way too much
>>> especially when the fdb hash size is small and static. We could work
>>> on making it dynamic though, but still these type of local entries
>>> per vlan per port can easily be avoided with this option.
>> 96000 bits can be stored in 12k.  Get where I'm going with this?
>>
>> Look at the problem sideways.
> Oh okay, I misunderstood your previous comment. I’ll look into that.
>
I just wanted to add the other problems we have had with keeping these 
macs (mostly from userspace POV):
- add/del netlink notification storms
- and large netlink dumps

In addition to in-kernel optimizations, will be nice to have a solution 
that reduces the burden on userspace. That will need a newer netlink 
dump format for fdbs. Considering all the changes needed, Nikolays patch 
seems less intrusive.



Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fPEFL7gFVrhQrryf5xKV+LQS/a3qR13kbUD3/f6S7vw=;
 b=KbYeJzz+kSttAWyicoItZNefAfvT6b0JW3qCBF2yA4Y/8CL5Zb/k13bD4v7PCMaRKs
 ekT3jIFa+QXRBDZIc+nfU6ChJq9ZFwhUop4SAwI+pnOvoDhmt24ZQNuoFTWuUbsF/Vu9
 1YwoW+hVnAWxm2+/NU4UKcm/t7TBuASqK8TSQ=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20200902112529.1570040-1-nikolay@cumulusnetworks.com>
 <20200902.125846.1328960907241014780.davem@davemloft.net>
 <16ed8f8a-2040-5546-5cea-09a8a5b0bd7b@cumulusnetworks.com>
Message-ID: <22c022da-4b1d-b0fe-b701-ce2163b3c3c0@cumulusnetworks.com>
Date: Wed, 2 Sep 2020 23:17:46 +0300
MIME-Version: 1.0
In-Reply-To: <16ed8f8a-2040-5546-5cea-09a8a5b0bd7b@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2 00/15] net: bridge: mcast: initial
 IGMPv3 support (part 1)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com

On 9/2/20 11:08 PM, Nikolay Aleksandrov wrote:
> On 9/2/20 10:58 PM, David Miller wrote:
>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> Date: Wed,  2 Sep 2020 14:25:14 +0300
>>
>>> Here're the sets that will come next (in order):
>>>   - Fast path patch-set which adds support for (S, G) mdb entries needed
>>>     for IGMPv3 forwarding, entry add source (kernel, user-space etc)
>>>     needed for IGMPv3 entry management, entry block mode needed for
>>>     IGMPv3 exclude mode. This set will also add iproute2 support for
>>>     manipulating and showing all the new state.
>>>   - Selftests patch-set which will verify all IGMPv3 state transitions
>>>     and forwarding
>>>   - Explicit host tracking patch-set, needed for proper fast leave and
>>>     with it fast leave will be enabled for IGMPv3
>>>
>>> Not implemented yet:
>>>   - Host IGMPv3 support (currently we handle only join/leave as before)
>>>   - Proper other querier source timer and value updates
>>>   - IGMPv3/v2 compat (I have a few rough patches for this one)
>>
>> What about ipv6 support?  The first thing I notice when reading these
>> patches is the source filter code only supports ipv4.
>>
> 
> Indeed, these are IGMPv3/IPv4 targeted. But MLDv2 should be relatively easy to
> add once we have all the set/state transitions as it uses the same.
> Adding both at once would be a much bigger change.
> 
> Once all the infra (with fast-path) for IGMPv3 is in, MLDv2 should be a much
> easier change, but I must admit given the amount of work this required I haven't
> yet looked into MLDv2 in details. The majority of the changes would be just switch
> protocol statements that take care of the IPv6 part.
> 
> I have also explicitly added the IPv4 checks right now to limit the dump code, otherwise
> we'd get for example group mode export for IPv6 entries which yet don't support it.
> 
> If you'd prefer I can remove the explicit IPv4 checks and leave the switch protocol check
> with ETH_P_IP only currently, but it wouldn't affect the end result much.

i. e. this doesn't exclude IPv6 or makes it worse for it, on the contrary the ops needed to
implement MLDv2 state transitions are in this set, they just need to be extended for v6.
The new br_ip src group field contains also a field for an IPv6 address.



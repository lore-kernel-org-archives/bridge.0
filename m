Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE78C81E80
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FCD981E65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duUT8E4UuVznxi1URA7/9KIa7Q1q0GAqecTAd9LPU9U=;
 b=CcvznQfXzeyZsD3wyfiFfJfntgQmnu0yYpnGCLfaqbHs+nWi1lvMJBr1zhlMmB/i/e
 RgKI6bDS3F4+PlHabLUY+RD2V3xVLqFC/Kzbk+D/OnzvJwDzn0I33LoDphR02ZECuzPt
 7P3cn1nJjZFVEZs3nYhsPDF246YnuzwQTpQuJiDh4XhprhvKesEtTvnEGujNg6sC64dX
 0KXDLo4bnY97Zjs7sVFQcap2LEZMxk5Uocm1AHqeD/IY58Eu4M/VnlNsh4JMDzDK0sBP
 zS2Oo6B39XJliMJX5QiMy4+WAqFxGVc2dZ/CnvGDh0JiL2zJ+01aMRabY735jkECcRUU
 Tk3A==
Message-ID: <0a820f10-f10f-64b7-14ba-58d9337cbb69@blackwall.org>
Date: Tue, 7 Feb 2023 22:02:58 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230204170801.3897900-1-idosch@nvidia.com>
 <3d7387d0-cff6-f403-55fc-1cb41e87db1a@blackwall.org>
 <Y+IZEJSwNZLH2aXN@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Y+IZEJSwNZLH2aXN@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 00/13] vxlan: Add MDB support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2/7/23 11:25, Ido Schimmel wrote:
> On Tue, Feb 07, 2023 at 12:24:25AM +0100, Nikolay Aleksandrov wrote:
>> Hmm, while I agree that having the control plane in user-space is nice,
>> I do like having a relatively straight-forward and well maintained
>> protocol implementation in the kernel too, similar to its IGMPv3 client
>> support which doesn't need third party packages or external software
>> libraries to work. That being said, I do have (an unfinished) patch-set
>> that adds a bridge daemon to FRR, I think we can always add a knob to
>> switch to some more advanced user-space daemon which can snoop.
>>
>> Anyway to the point - this patch-set looks ok to me, from bridge PoV
>> it's mostly code shuffling, and the new vxlan code is fairly straight-
>> forward.
> 
> Thanks for taking a look. I was hoping you would comment on this
> section... :)
>

:)

> After sending the RFC I realized that what I wrote about the user space
> implementation is not accurate. An AF_PACKET socket opened on the VXLAN
> device will only give you the decapsulated IGMP / MLD packets. You
> wouldn't know from which remote VTEP they arrived. However, my point
> still stands: As long as the kernel is not performing snooping we can
> defer the forming of the replication lists to user space and avoid the
> complexity of the "added_by_star_ex" entries (among many other things).
> If in the future we need to implement snooping in the kernel, then we
> will expose a new knob (e.g., "mcast_snooping", default off), which will
> also enable the "added_by_star_ex" entries.
> 

Yep, I agree that it would be best for this case and we don't need the 
extra complexity in the kernel. I was referring more to the standard
IGMPv3 implementation (both client and bridge).

> I tried looking what other implementations are doing and my impression
> is that by "VXLAN IGMP snooping" they all refer to the snooping done in
> the bridge driver. That is, instead of treating the VXLAN port as a
> router port, the bridge will only forward specific groups to the VXLAN
> port, but this multicast traffic will be forwarded to all the VTEPs.
> This is already supported by the kernel.
> 
> Regarding what you wrote about a new knob in the bridge driver, you mean
> that this knob will enable MDB lookup regardless of "mcast_snooping"?

Yep, we can implement the snooping logic in user-space and use the
bridge only as a dataplane (that's what my bridge daemon in frr was
going to do for IGMPv3 and also explicit host tracking).

> Currently this knob enables both snooping and MDB lookup. Note that I
> didn't add a new knob to the VXLAN device because I figured that if user
> space doesn't want MDB lookup, then it will not configure MDB entries.
>

Yeah, of course. The set makes sense as it is since vxlan's logic would
be in user-space.

> Thanks!


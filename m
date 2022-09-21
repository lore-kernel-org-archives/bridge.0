Return-Path: <nicolas.dichtel@6wind.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5B04607FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61314606EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6wind.com; s=google;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date;
 bh=rUO6t6C3l9V7+NJRQvXy0uGhA6vMbQwppUZNMvDDpV8=;
 b=FXGNEyoJ6TsxJT/6jnwzdEYEYt1X515xt7/Jhk/45XOE+8eGOFiXA/Hpb+Uj5wjO4k
 dpvq2t2OrrobHCE3A1uLZq4sJ85dpbR/4O6LW73t0CVSUWoR3HtPjmHd4yiz/T65PQhb
 1S08uTdvI2ZRtrJHrAYuz+UJS6QnnnaloiOMVuqhPvpAd+i7Q1WlihyBPbQdy2lcYTrs
 d/Bc7XNHJC1bBj7STOS6tkrZ/r/EUXbRRyNe/sBulywi/NzOD6r0ZoY6IHx4Abax1vVa
 wQOh1QX8K3zoEjUnYP3am1l0Fhjuqk2WLTMKUSiS/2bgq5cMXALRiKKzJLAHNdyCcGQM
 KhzQ==
Message-ID: <99b9a532-5feb-fe00-3d4e-29d560d34dc0@6wind.com>
Date: Wed, 21 Sep 2022 08:43:37 +0200
MIME-Version: 1.0
Reply-To: nicolas.dichtel@6wind.com
Content-Language: en-US
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-5-razor@blackwall.org>
 <0198618f-7b52-3023-5e9f-b38c49af1677@6wind.com>
 <f26fa81a-dc13-6a27-2e63-74b13359756e@blackwall.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
In-Reply-To: <f26fa81a-dc13-6a27-2e63-74b13359756e@blackwall.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v4 04/12] net: netlink: add NLM_F_BULK
 delete request modifier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net


Le 20/09/2022 à 11:05, Nikolay Aleksandrov a écrit :
> On 20/09/2022 10:49, Nicolas Dichtel wrote:
>>
>> Le 13/04/2022 à 12:51, Nikolay Aleksandrov a écrit :
>>> Add a new delete request modifier called NLM_F_BULK which, when
>>> supported, would cause the request to delete multiple objects. The flag
>>> is a convenient way to signal that a multiple delete operation is
>>> requested which can be gradually added to different delete requests. In
>>> order to make sure older kernels will error out if the operation is not
>>> supported instead of doing something unintended we have to break a
>>> required condition when implementing support for this flag, f.e. for
>>> neighbors we will omit the mandatory mac address attribute.
>>> Initially it will be used to add flush with filtering support for bridge
>>> fdbs, but it also opens the door to add similar support to others.
>>>
>>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>>> ---
>>>  include/uapi/linux/netlink.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
>>> index 4c0cde075c27..855dffb4c1c3 100644
>>> --- a/include/uapi/linux/netlink.h
>>> +++ b/include/uapi/linux/netlink.h
>>> @@ -72,6 +72,7 @@ struct nlmsghdr {
>>>  
>>>  /* Modifiers to DELETE request */
>>>  #define NLM_F_NONREC	0x100	/* Do not delete recursively	*/
>>> +#define NLM_F_BULK	0x200	/* Delete multiple objects	*/
>> Sorry to reply to an old patch, but FWIW, this patch broke the uAPI.
>> One of our applications was using NLM_F_EXCL with RTM_DELTFILTER. This is
>> conceptually wrong but it was working. After this patch, the kernel returns an
>> error (EOPNOTSUPP).
>>
>> Here is the patch series:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=92716869375b
>>
>> We probably can't do anything now, but to avoid this in the future, I see only
>> two options:
>>  - enforce flags validation depending on the operation (but this may break some
>>    existing apps)
>>  - stop adding new flags that overlap between NEW and DEL operations (by adding
>>    a comment or defining dummy flags).
>>
>> Any thoughts?
>>
> 
> Personally I'd prefer to enforce validation so we don't lose the flags because of buggy user-space
> applications, but we can break someone (who arguably should fix their app though). We already had
> that discussion while the set was under review[1] and just to be a bit more confident I also
Thanks for the link. Finally, someone has (almost) complained :D

> tried searching for open-source buggy users, but didn't find any.
The trend seems to let someone else add another specific flag if needed. Thus,
it seems that checking flags is the way to go.
The pro is that if someone complains, the patch could be reverted, which is not
the case for a new feature like this bulk for example.


Regards,
Nicolas

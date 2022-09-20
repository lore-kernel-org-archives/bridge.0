Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAA294172F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5025B408BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=mzfcqpBkglh/gR500QL3rZ/H+YTKdF7NYoFfORcrUF8=;
 b=nvC7B5puBTkanDM2WAtQpj1DNNpkPTP5davaWRsUkcxnKe6ZC9G1ytrMkFHrKKA3mu
 Ejme7m7jGZGm7levGS6nGS3XQtesd8RLF6snWkWieIYfc7y9DIKLH9DwhuwQKrWIHdUu
 ohiUx0cyND8cY31YsjSGX11CR7PgiqsnsD5wmv+EZaVaSn2PJZQ7ivk8At966B9j+MDf
 HBPx9frB57nB5rEY9wsElR9bmlOwZgH6sHGLKJc4jgRyxCjMcNxbRTSqV++/k4V44JeL
 TgUsZtShVuQdU8PeGJV0OjdSqIkTXvG1Bg99tPCGzjg0tr2VbBF7GM/bCw0mzN07x7JS
 vqEg==
Message-ID: <f26fa81a-dc13-6a27-2e63-74b13359756e@blackwall.org>
Date: Tue, 20 Sep 2022 12:05:24 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-5-razor@blackwall.org>
 <0198618f-7b52-3023-5e9f-b38c49af1677@6wind.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0198618f-7b52-3023-5e9f-b38c49af1677@6wind.com>
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
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: dsahern@kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 20/09/2022 10:49, Nicolas Dichtel wrote:
> 
> Le 13/04/2022 à 12:51, Nikolay Aleksandrov a écrit :
>> Add a new delete request modifier called NLM_F_BULK which, when
>> supported, would cause the request to delete multiple objects. The flag
>> is a convenient way to signal that a multiple delete operation is
>> requested which can be gradually added to different delete requests. In
>> order to make sure older kernels will error out if the operation is not
>> supported instead of doing something unintended we have to break a
>> required condition when implementing support for this flag, f.e. for
>> neighbors we will omit the mandatory mac address attribute.
>> Initially it will be used to add flush with filtering support for bridge
>> fdbs, but it also opens the door to add similar support to others.
>>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  include/uapi/linux/netlink.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
>> index 4c0cde075c27..855dffb4c1c3 100644
>> --- a/include/uapi/linux/netlink.h
>> +++ b/include/uapi/linux/netlink.h
>> @@ -72,6 +72,7 @@ struct nlmsghdr {
>>  
>>  /* Modifiers to DELETE request */
>>  #define NLM_F_NONREC	0x100	/* Do not delete recursively	*/
>> +#define NLM_F_BULK	0x200	/* Delete multiple objects	*/
> Sorry to reply to an old patch, but FWIW, this patch broke the uAPI.
> One of our applications was using NLM_F_EXCL with RTM_DELTFILTER. This is
> conceptually wrong but it was working. After this patch, the kernel returns an
> error (EOPNOTSUPP).
> 
> Here is the patch series:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=92716869375b
> 
> We probably can't do anything now, but to avoid this in the future, I see only
> two options:
>  - enforce flags validation depending on the operation (but this may break some
>    existing apps)
>  - stop adding new flags that overlap between NEW and DEL operations (by adding
>    a comment or defining dummy flags).
> 
> Any thoughts?
> 

Personally I'd prefer to enforce validation so we don't lose the flags because of buggy user-space
applications, but we can break someone (who arguably should fix their app though). We already had
that discussion while the set was under review[1] and just to be a bit more confident I also
tried searching for open-source buggy users, but didn't find any.

> Regards,
> Nicolas

[1] https://lore.kernel.org/netdev/97774474-65a3-fa45-e0b9-8db6c748da28@kernel.org/t/#m23018ce831dae16d42cb9c393c7c6bad1bc621c3

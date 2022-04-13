Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=AkGklnty57yCILmUblbJRB8X6WGVVTnSwjTLFB+Ahyg=;
 b=zEjDLJeNwDYO20naLR11cjx1Ddm5ja6P93pjnR9KqLYy6aYXUjVBkGik/xCW6jxQ2S
 pZLxk6SE2PsQ4LpxUPJYvq++DWdvrCSfjCqp2PJMt9TklorXz5yHar0poqG34egddajr
 yytuTvCh1H1AiwPiCCI8/TSp2CaWA9mDjcjWs9Yi0sYZbwQQqgPuFiblKIe+7GowiONv
 HdrPc/KlJ9xX7nefFkCgSIsTjQPigqgvtlFCIve7Gnfj1p84aJSEiJ/fQdAL/xAdwsNf
 RjIp7syMVwSTmqlT/B5kGjPtc1+1oiBvPYdNkNVQTle0JGvxH5cdQSwXSQ5dUzj1T9zF
 DfPw==
Message-ID: <e43b5033-d350-fc81-71be-de3e1053c72a@blackwall.org>
Date: Wed, 13 Apr 2022 15:21:13 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220413105202.2616106-1-razor@blackwall.org>
 <20220413105202.2616106-6-razor@blackwall.org> <Yla8wj7khYxpwxan@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Yla8wj7khYxpwxan@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 05/12] net: rtnetlink: add bulk
 delete support flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On 13/04/2022 15:06, Ido Schimmel wrote:
> On Wed, Apr 13, 2022 at 01:51:55PM +0300, Nikolay Aleksandrov wrote:
>> Add a new rtnl flag (RTNL_FLAG_BULK_DEL_SUPPORTED) which is used to
>> verify that the delete operation allows bulk object deletion. Also emit
>> a warning if anyone tries to set it for non-delete kind.
>>
>> Suggested-by: David Ahern <dsahern@kernel.org>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>> v4: new patch
>>
>>  include/net/rtnetlink.h | 3 ++-
>>  net/core/rtnetlink.c    | 8 ++++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
>> index 0bf622409aaa..bf8bb3357825 100644
>> --- a/include/net/rtnetlink.h
>> +++ b/include/net/rtnetlink.h
>> @@ -10,7 +10,8 @@ typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
>>  typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
>>  
>>  enum rtnl_link_flags {
>> -	RTNL_FLAG_DOIT_UNLOCKED = BIT(0),
>> +	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
>> +	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
>>  };
>>  
>>  enum rtnl_kinds {
>> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>> index beda4a7da062..63c7df52a667 100644
>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -249,6 +249,8 @@ static int rtnl_register_internal(struct module *owner,
>>  	if (dumpit)
>>  		link->dumpit = dumpit;
>>  
>> +	WARN_ON(rtnl_msgtype_kind(msgtype) != RTNL_KIND_DEL &&
>> +		(flags & RTNL_FLAG_BULK_DEL_SUPPORTED));
>>  	link->flags |= flags;
>>  
>>  	/* publish protocol:msgtype */
>> @@ -6009,6 +6011,12 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  	}
>>  
>>  	flags = link->flags;
>> +	if (kind == RTNL_KIND_DEL && (nlh->nlmsg_flags & NLM_F_BULK) &&
>> +	    !(flags & RTNL_FLAG_BULK_DEL_SUPPORTED)) {
>> +		NL_SET_ERR_MSG(extack, "Bulk delete is not supported");
>> +		goto err_unlock;
> 
> If a buggy user space application is sending messages with NLM_F_BULK
> set (unintentionally), will it break on newer kernel? I couldn't find
> where the kernel was validating that reserved flags are not used (I
> suspect it doesn't).

Correct, it doesn't.

> 
> Assuming the above is correct and of interest, maybe just emit a warning
> via extack and drop the goto? Alternatively, we can see if anyone
> complains which might never happen
> 

TBH I prefer to error out on an unsupported flag, but I get the problem. These
weren't validated before and we start checking now. The problem is that we'll
return an extack without an error, but the delete might also remove something.
Hrm.. perhaps we can rephrase the error in that case (since it becomes a warning
in iproute2 terms):
 "NLM_F_BULK flag is set but bulk delete operation is not supported"
So it will warn the user it has an unsupported flag.

WDYT ?

IMO we should bite the bullet and keep the error though. :)

>> +	}
>> +
>>  	if (flags & RTNL_FLAG_DOIT_UNLOCKED) {
>>  		doit = link->doit;
>>  		rcu_read_unlock();
>> -- 
>> 2.35.1
>>


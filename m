Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=nSeFs2yVD8NX7vddfI8VI73khKYUKDMhthuu9Zyx8d4=;
	b=I99QAtfGlM5SlXnuFlffI4Zt5Q0gxRqPXaVplDOc5WNOYOtJlwpLWu6DuEuJL6DPxy
	YtlqGxSENGie4Ol/hIV5eeGMyYQLTjBd4WAZYUKdIfF6QAw4LZ5NUC2IKejKt3pREJkU
	3YzhzUzM+XM/GcBFEDTQ6Gv/rP0W/P50KpltI=
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
	<20180721.232733.468047452825591471.davem@davemloft.net>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9f9b46b6-e4d6-78da-27a9-50752c0de027@cumulusnetworks.com>
Date: Sun, 22 Jul 2018 10:41:14 +0300
MIME-Version: 1.0
In-Reply-To: <20180721.232733.468047452825591471.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
 sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com

On 22/07/18 09:27, David Miller wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Fri, 20 Jul 2018 17:48:25 +0300
> 
>> +		spin_lock_bh(&p->br->lock);
>> +		ret = brport_attr->store_raw(p, (char *)buf);
>> +		spin_unlock_bh(&p->br->lock);
> 
> Please respect the const here.
> 
> Have the methods do a kstrncup(); ... kfree(); sequence if they have
> to mangle the contents when there is a newline inside.
> 
> I know the caller is passing in what was a non-const char pointer,
> I've looked at the implementation, but it might be that way forever.
> 
> I looked at all other sysfs writes that need to do this \n --> \0
> mangling and they either copy the string first into a static buffer
> or they do the kstrncup() thing.
> 
> Thank you.
> 

Okay, will do. I'll also prepare a separate patch for the bonding, 
it does a cast like this in bonding_sysfs_store_option().

Thanks

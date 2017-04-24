Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=3a0Tbu4YGS0e56VOSDcBtnxqkQ/rW+chb+YUk1UyVco=;
	b=dzvGBSAucdGgODXZN/Q3kg1p9L5UVhtNzn6fR57hXQxdqTzAsrL1vp/MAM4QrD9oeb
	Bo4tDb4z87IqpJ4Km1sSdbXiozp5l51u0UiAN/ClHWtyvzVkrxwQzNAkjA4+lUPWbvnJ
	Y75wu9gO7jc1ogcoU4tSWpkSU6CCmSf2ycfqo=
References: <a8b2b2c876f416431dac031a0beb7ce079c7d0a9.1493018730.git.lucien.xin@gmail.com>
	<3d77b47d-c8c3-de57-946e-59096a88964e@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <354b75ce-3eab-4b73-75d9-2b235331359f@cumulusnetworks.com>
Date: Mon, 24 Apr 2017 14:29:12 +0300
MIME-Version: 1.0
In-Reply-To: <3d77b47d-c8c3-de57-946e-59096a88964e@cumulusnetworks.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: shutdown bridge device before
	removing it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On 24/04/17 14:01, Nikolay Aleksandrov wrote:
> On 24/04/17 10:25, Xin Long wrote:
>> During removing a bridge device, if the bridge is still up, a new mdb entry
>> still can be added in br_multicast_add_group() after all mdb entries are
>> removed in br_multicast_dev_del(). Like the path:
>>
>>   mld_ifc_timer_expire ->
>>     mld_sendpack -> ...
>>       br_multicast_rcv ->
>>         br_multicast_add_group
>>
>> The new mp's timer will be set up. If the timer expires after the bridge
>> is freed, it may cause use-after-free panic in br_multicast_group_expired.
>> This can happen when ip link remove a bridge or destroy a netns with a
>> bridge device inside.
>>
>> As we can see in br_del_bridge, brctl is also supposed to remove a bridge
>> device after it's shutdown.
>>
>> This patch is to call dev_close at the beginning of br_dev_delete so that
>> netif_running check in br_multicast_add_group can avoid this issue. But
>> to keep consistent with before, it will not remove the IFF_UP check in
>> br_del_bridge for brctl.
>>
>> Reported-by: Jianwen Ji <jiji@redhat.com>
>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
>> ---
>>  net/bridge/br_if.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> +CC bridge maintainers
> 
> I can see how this could happen, could you also provide the traceback ?
> 
> The patch looks good to me, actually I think it fixes another issue with
> mcast stats where the percpu pointer can be accessed after it's freed if
> an mcast packet can get sent via br->dev after the br_multicast_dev_del() call.

Never mind the another issue part, Ido's recent ndo_uninit() patch fixed it.

> This is definitely stable material, if I'm not mistaken the issue is there since
> the introduction of br_dev_delete:
> commit e10177abf842
> Author: Satish Ashok <sashok@cumulusnetworks.com>
> Date:   Wed Jul 15 07:16:51 2015 -0700
> 
>     bridge: multicast: fix handling of temp and perm entries
> 
> 
> 
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> 
> 
> 
> 
> 
> 


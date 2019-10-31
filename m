Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=TnCbq2000sgK9KKfW0a0I1LlWJLVNeCp1tHN1Di2rZ0=;
	b=K4WeBKfV4LVJUx9dWAsJXRPNV5GU2cS/3jB7ikEIQNTer3zdMFt55qG5Dv3SG0otQ2
	XgYvoxht5SxklhFM/+jjbxfv/50HS2Oa/WQ2lBh/qeNEIvyWWQnT3obeCZUsEaSTCLwp
	8BvACCPR4tHb1dtnWdgF7RweVv2ZNg7HD4Jl0=
References: <20191029114559.28653-1-nikolay@cumulusnetworks.com>
	<8e21b79c1adf5c3c4fb94c11fbe30371c4e96943.camel@perches.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <14ab24ad-e730-989a-db61-9cd377104a7a@cumulusnetworks.com>
Date: Thu, 31 Oct 2019 21:28:01 +0200
MIME-Version: 1.0
In-Reply-To: <8e21b79c1adf5c3c4fb94c11fbe30371c4e96943.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: convert fdbs to use
	bitops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 31/10/2019 20:37, Joe Perches wrote:
> On Tue, 2019-10-29 at 13:45 +0200, Nikolay Aleksandrov wrote:
>> Hi,
>> We'd like to have a well-defined behaviour when changing fdb flags. The
>> problem is that we've added new fields which are changed from all
>> contexts without any locking. We are aware of the bit test/change races
>> and these are fine (we can remove them later), but it is considered
>> undefined behaviour to change bitfields from multiple threads and also
>> on some architectures that can result in unexpected results,
>> specifically when all fields between the changed ones are also
>> bitfields. The conversion to bitops shows the intent clearly and
>> makes them use functions with well-defined behaviour in such cases.
>> There is no overhead for the fast-path, the bit changing functions are
>> used only in special cases when learning and in the slow path.
>> In addition this conversion allows us to simplify fdb flag handling and
>> avoid bugs for future bits (e.g. a forgetting to clear the new bit when
>> allocating a new fdb). All bridge selftests passed, also tried all of the
>> converted bits manually in a VM.
>>
>> Thanks,
>>  Nik
>>
>> Nikolay Aleksandrov (7):
>>   net: bridge: fdb: convert is_local to bitops
>>   net: bridge: fdb: convert is_static to bitops
>>   net: bridge: fdb: convert is_sticky to bitops
>>   net: bridge: fdb: convert added_by_user to bitops
>>   net: bridge: fdb: convert added_by_external_learn to use bitops
>>   net: bridge: fdb: convert offloaded to use bitops
>>   net: bridge: fdb: set flags directly in fdb_create
> 
> Wouldn't it be simpler to change all these bitfields to bool?
> 
> The next member is ____cachline_aligned_in_smp so it's not
> like the struct size matters or likely even changes.
> 

I guess it's just preference now, I'd prefer having 1 field which is well
packed and can contain more bits (and more are to come) instead of bunch
of bool or u8 fields which is a waste of space. We can set them together, it's more
compact and also the atomic bitops make it clear that these can change
without any locking. We're about to add new bits to these and it's nice
to have a clear understanding and well-defined API for them. Specifically
the test_and_set/clear_bit() can simplify code considerably.

> ---
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index ce2ab1..46d2f10 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -183,12 +183,12 @@ struct net_bridge_fdb_entry {
>  
>  	struct net_bridge_fdb_key	key;
>  	struct hlist_node		fdb_node;
> -	unsigned char			is_local:1,
> -					is_static:1,
> -					is_sticky:1,
> -					added_by_user:1,
> -					added_by_external_learn:1,
> -					offloaded:1;
> +	bool				is_local;
> +	bool				is_static;
> +	bool				is_sticky;
> +	bool				added_by_user;
> +	bool				added_by_external_learn;
> +	bool				offloaded;
>  
>  	/* write-heavy members should not affect lookups */
>  	unsigned long			updated ____cacheline_aligned_in_smp;
> 
> 


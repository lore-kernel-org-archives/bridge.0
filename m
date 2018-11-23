Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fx/WlrxRb8snjid6GZpOFZ/c6mgvS5r11mneWWbDT0o=;
	b=ClTPAUHWfjhXytoyw7L7vJ+D1Zyl2CERzYEn2onvDvDMyRmSZXmHGiZBBj6w6HC9OQ
	9/Bx3uUkmrS9jn0h3Ppied3+JWCca0W20L5CFJlJ6whV2YjQgSfjWAjKDdXff8sjJ7Js
	TcystNHtlgw+QZAnO4q9ooyF8B9oyVgucAy6k=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-2-nikolay@cumulusnetworks.com>
	<20181122154951.GG15403@lunn.ch>
	<47484385-f944-e8bf-c358-e3436dfd776d@cumulusnetworks.com>
Message-ID: <c5d16533-8a53-a418-08df-499fa82bb6f9@cumulusnetworks.com>
Date: Fri, 23 Nov 2018 03:55:24 +0200
MIME-Version: 1.0
In-Reply-To: <47484385-f944-e8bf-c358-e3436dfd776d@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for
 user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 22/11/2018 18:13, Nikolay Aleksandrov wrote:
<snip>
>>> +int br_boolopt_multi_toggle(struct net_bridge *br,
>>> +			    struct br_boolopt_multi *bm)
>>> +{
>>> +	unsigned long bitmap = bm->optmask;
>>> +	int err = 0;
>>> +	int opt_id;
>>> +
>>> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>>> +		bool on = !!(bm->optval & BIT(opt_id));
>>> +
>>> +		err = br_boolopt_toggle(br, opt_id, on);
>>> +		if (err) {
>>> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
>>> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
>>> +			break;
>>> +		}
>>
>> An old kernel with a new iproute2 might partially succeed in toggling
>> some low bits, but then silently ignore a high bit that is not
>> supported by the kernel. As a user, i want to know the kernel does not
>> support an option i'm trying to toggle.
>>
> 
> That is already how netlink option setting works, if the option isn't supported
> it is silently ignored. I tried to stay as close to the current behaviour as possible.
> It also applies to partial option changes, some options will be changed until an error
> is encountered.
> 
>> Can you walk all the bits in the u32 from the MSB to the LSB? That
>> should avoid this problem.
>>
> 
> I did wonder about this and left it as netlink option behaviour but
> I can leave the walk as is and just check if the highest order set bit >= BR_BOOLOPT_MAX
> and err out with ENOTSUPP for example. Will reconsider for v2.
> 

Actually this doesn't improve user experience, after testing a little the problem is
that we can't return to the user the exact option that failed in any understandable manner.
The options are:
 - exact error message: (no bit/option value) so pretty much just say "Failed bool option"
 - pr_err: this has 2 issues, first it can't be retrieved by the caller (will be in the logs)
           and more importantly the best we can do is print the option bit that we don't support
           which really doesn't help the user at all

So the example is having newer iproute2 on older kernel and trying to set non-existing option
mixed with existing ones - the user has no way of determining which one failed even if we print
the bit, so this is really frustrating. The current way of ignoring the missing options seems
a bit more user-friendly and also with the change that we return the supported bit options
in optmask (thanks for the suggestion), the user-space tool (iproute2) can determine if an
option is not supported and at least give an indication when dumping it.
All of this does align with how netlink currently handles options and people are used to it.




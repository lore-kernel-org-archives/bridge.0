Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mDQUGhhwCO/1yHUZApLXhQzE7mgIe1bTvyg7Yk/0sTM=;
	b=XlcEh+xw5kG7mR2ecOIPogtscIPTb90Z6zWbjdQnhtoeqIzmW+aLFgnqGxSOf5ZHO0
	5CEejUPYASo/YU06RMmkOQ0gUBr0ylFC3RSPaH6Tg7QvtEvLlJyPCDa+s8Dn/9RbYvfO
	JzSZbDUkGKQpgGLD5mpMr1Nci69OahCimrW7A=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
	<66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
	<20181124162541.GC24681@lunn.ch>
	<98A5C526-DBF7-40F0-9CB0-1C7AF7A5CF32@cumulusnetworks.com>
Message-ID: <bc90dc53-b4fc-3725-7141-556e62f027f8@cumulusnetworks.com>
Date: Sun, 25 Nov 2018 10:12:45 +0200
MIME-Version: 1.0
In-Reply-To: <98A5C526-DBF7-40F0-9CB0-1C7AF7A5CF32@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/3] net: bridge: add support for
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

On 24/11/2018 18:46, nikolay@cumulusnetworks.com wrote:
> On 24 November 2018 18:25:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Sat, Nov 24, 2018 at 06:18:33PM +0200, nikolay@cumulusnetworks.com
>> wrote:
>>> On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:
>>>>> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id
>> opt,
>>>> bool on,
>>>>> +		      struct netlink_ext_ack *extack)
>>>>> +{
>>>>> +	switch (opt) {
>>>>> +	default:
>>>>> +		/* shouldn't be called with unsupported options */
>>>>> +		WARN_ON(1);
>>>>> +		break;
>>>>
>>>> So you return 0 here, meaning the br_debug() lower down will not
>>>> happen. Maybe return -EOPNOTSUPP?
>>>>
>>>
>>> No, the idea here is that some option in the future might return an
>> error. 
>>> This function cannot be called with unsupported option thus the warn.
>>
>>
>> O.K, i was trying to make it easier to see which option caused it to
>> happen.
>>
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>
>>>>> +int br_boolopt_multi_toggle(struct net_bridge *br,
>>>>> +			    struct br_boolopt_multi *bm,
>>>>> +			    struct netlink_ext_ack *extack)
>>>>> +{
>>>>> +	unsigned long bitmap = bm->optmask;
>>>>> +	int err = 0;
>>>>> +	int opt_id;
>>>>> +
>>>>> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>>>>> +		bool on = !!(bm->optval & BIT(opt_id));
>>>>> +
>>>>> +		err = br_boolopt_toggle(br, opt_id, on, extack);
>>>>> +		if (err) {
>>>>> +			br_debug(br, "boolopt multi-toggle error: option: %d current:
>> %d
>>>> new: %d error: %d\n",
>>>>> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>
>>>> Does the semantics of extack allow you to return something even when
>>>> there is no error? If there are bits > BR_BOOLOPT_MAX you could
>> return
>>>> 0, but also add a warning in extack that some bits where not
>> supported
>>>> by this kernel.
>>>
>>> If we return 0 there's no reason to check extack. 
>>
>> Well, the caller can check to see if extack is present, even on
>> success. This is extack, not extnack after all...
>>
> 
> Evenif it's possible to return it without an error (I need to confirm that), the real problem is extack doesn't support
> format strings, i. e. we can't say which bit is missing which makes it useless in this case IMO. 
> 

One more thing I forgot to mention is the case with newer iproute2 and older kernel without
these patches, then the whole boolopt option will be ignored without setting extact which
makes it inconsistent if user-space would rely on that to check if options were set.
I think the best way to go if one wants to check for support is to dump the boolopts
if they're present, then optmask could be used to see what will be set (or was set).
That would be reliable in all cases.


>> 	 Andrew
> 


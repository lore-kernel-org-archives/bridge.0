Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Wf7pEUq8wz9tRL8u9E4w/keIXT6lm7/AnKBciuNYQyI=;
	b=gOP3JIOpjy/X3Ik6G+Trd1qnauLcYAdeS5ZaackckOka43k+5KWKfwVYvJORpSqZ+v
	dZ15FW//vkNShFrvXvaHgUo9Ma+OuZuQ9GEORFztumr74hEXvTgs3U4YFmUKo3pIygnm
	z0Q3cuykFzT6f49kEanaspv1CyvlwMveInQws=
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-2-nikolay@cumulusnetworks.com>
	<20181122154951.GG15403@lunn.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <47484385-f944-e8bf-c358-e3436dfd776d@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 18:13:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181122154951.GG15403@lunn.ch>
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

On 22/11/2018 17:49, Andrew Lunn wrote:
>> +/* br_boolopt_toggle - change user-controlled boolean option
>> + *
>> + * @br: bridge device
>> + * @opt: id of the option to change
>> + * @on: new option value
>> + *
>> + * Changes the value of the respective boolean option to @on taking care of
>> + * any internal option value mapping and configuration.
>> + */
>> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on)
>> +{
>> +	int err = -ENOENT;
>> +
>> +	switch (opt) {
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return err;
>> +}
>> +
> 
> 
>> +int br_boolopt_multi_toggle(struct net_bridge *br,
>> +			    struct br_boolopt_multi *bm)
>> +{
>> +	unsigned long bitmap = bm->optmask;
>> +	int err = 0;
>> +	int opt_id;
>> +
>> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
>> +		bool on = !!(bm->optval & BIT(opt_id));
>> +
>> +		err = br_boolopt_toggle(br, opt_id, on);
>> +		if (err) {
>> +			br_debug(br, "boolopt multi-toggle error: option: %d current: %d new: %d error: %d\n",
>> +				 opt_id, br_boolopt_get(br, opt_id), on, err);
>> +			break;
>> +		}
> 
> An old kernel with a new iproute2 might partially succeed in toggling
> some low bits, but then silently ignore a high bit that is not
> supported by the kernel. As a user, i want to know the kernel does not
> support an option i'm trying to toggle.
> 

That is already how netlink option setting works, if the option isn't supported
it is silently ignored. I tried to stay as close to the current behaviour as possible.
It also applies to partial option changes, some options will be changed until an error
is encountered.

> Can you walk all the bits in the u32 from the MSB to the LSB? That
> should avoid this problem.
> 

I did wonder about this and left it as netlink option behaviour but
I can leave the walk as is and just check if the highest order set bit >= BR_BOOLOPT_MAX
and err out with ENOTSUPP for example. Will reconsider for v2.

> 	Andrew
> 


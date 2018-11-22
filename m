Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=zfpHWXEmuW9tgwzAtiJWKWgIXOCXDIWda8UNakP1luk=;
	b=POTYkrfAzzcU+lpggPQ3tSxoQt3AUBMZGgsbVYq5cBch3kELWBaCUwS+7yhWeDzXFI
	KMhPGb/UPiQbnlWXv1luU8dSBXaAedbBwQLAwgbvpQQHS7z5GN6DH2n/yDN82frqKFzP
	Cji4m8BGRSHnCJAP3EwlKZWNTmwKYwJMarHn4=
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-2-nikolay@cumulusnetworks.com>
	<20181122155256.GH15403@lunn.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a676429f-7352-d10b-1e95-b9b357479a73@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 18:07:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181122155256.GH15403@lunn.ch>
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

On 22/11/2018 17:52, Andrew Lunn wrote:
>> +void br_boolopt_multi_get(const struct net_bridge *br,
>> +			  struct br_boolopt_multi *bm)
>> +{
>> +	u32 optval = 0;
>> +	int opt_id;
>> +
>> +	for (opt_id = 0; opt_id < BR_BOOLOPT_MAX; opt_id++)
>> +		optval |= (br_boolopt_get(br, opt_id) << opt_id);
>> +
>> +	bm->optval = optval;
>> +	bm->optmask = 0;
> 
> Maybe set optmask to indicate which bits this kernel supports?
> 

I like the idea, will add for v2.

Thanks,
 Nik

>       Andrew
> 


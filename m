Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Uu1eZLi5YQra1TH7F2BKXRh1ceNMy5PIDeSFY+0chLc=;
	b=Q1LSeiMRKqczevLCkLh9rUAsrWGPXenMjwdDQWX+Gb7d6EM3LCFlUIDbpKzy61HQwo
	ri28oEhxUnx1/q6+q8nRL0RTd1XrpudO4Rquornmr5/KZvNKMcPMxQ0tW8gF21J8mBLP
	dW2/2Fy05kD04Bi/8VyItV355oN6z0fLUPQXlyW+5CSZSnR4eSjA2Kqpd9Ko1Slz3/Ep
	PNDbjUB/WDN71rBON0NXor+dGVjbeeyR/Y84vNRm8MHCLxPSNPJpiOjqDFV+y8ReLzZY
	ks5CiT5lhLEiCAMIzLp6MTZTLbd0c+tNBWjc7rxNvIvXuGSyQDa8uF0XK3g3bWKlwcKN
	Jz7w==
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
	<1507093134-20406-6-git-send-email-dsahern@gmail.com>
	<20171004063828.GB1895@nanopsycho>
From: David Ahern <dsahern@gmail.com>
Message-ID: <354fae78-3b04-3807-7392-87c6a3f1b3db@gmail.com>
Date: Wed, 4 Oct 2017 08:35:46 -0700
MIME-Version: 1.0
In-Reply-To: <20171004063828.GB1895@nanopsycho>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 5/7] net: bonding: Add extack messages
 for some enslave failures
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, vfalico@gmail.com, j.vosburgh@gmail.com, davem@davemloft.net

On 10/3/17 11:38 PM, Jiri Pirko wrote:
> Wed, Oct 04, 2017 at 06:58:52AM CEST, dsahern@gmail.com wrote:
>> A number of bond_enslave errors are logged using the netdev_err API.
>> Return those messages to userspace via the extack facility.
>>
>> Signed-off-by: David Ahern <dsahern@gmail.com>
>> ---
>> drivers/net/bonding/bond_main.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>> index bc92307c2082..6688dc9154e0 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -1348,12 +1348,15 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>
>> 	/* already in-use? */
>> 	if (netdev_is_rx_handler_busy(slave_dev)) {
>> +		NL_SET_ERR_MSG(extack,
>> +			       "Device is in use and cannot be enslaved");
> 
> Please don't do this kind of wrapping. Just let the string be on the
> same line.
> 

Ok, I will do that for bonding only since it is the existing style.

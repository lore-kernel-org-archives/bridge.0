Return-Path: <dsahern@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=XtsgixvirIgaOkYv9ihsQ8c+pIBONw4g41YxdbfsPXI=;
	b=Sr/gI5e3l8kMWXaf+SCjHSz+ax/mcqECKIks1zjSBdeI0rMKdutwvk4M+vLlXISSkA
	66ubhvTGrifm6crLjURDcEC8FxfHk6qn2qPh0/YJngF/YGmf/X8FKX7QZvkL4pV0o19k
	rCQo8DKdzx8HsuWd9t1Qq4ljmSxKBzcZSJtuNREzamRGhD/LJEgofm4/s9YA0BEKNXhC
	1/SSAl5DGflqZHvMk4oI/nYWbOdFz3nKjL9lMs7cebv1F44CJcQXi3x52MaWcJWTJEmf
	9rQbVC3HyeSKLyh6K4MbpaaiHXKdNriykGKXHYeDTN1MGxRpP2qV6BYLwfRoTTFHucIX
	/5rQ==
References: <1507093134-20406-1-git-send-email-dsahern@gmail.com>
	<1507093134-20406-6-git-send-email-dsahern@gmail.com>
	<20171004063828.GB1895@nanopsycho>
	<354fae78-3b04-3807-7392-87c6a3f1b3db@gmail.com>
	<20171004180428.GG1895@nanopsycho>
From: David Ahern <dsahern@gmail.com>
Message-ID: <1d18c43d-0604-3d38-2b68-ca3c7d1ab754@gmail.com>
Date: Wed, 4 Oct 2017 11:06:16 -0700
MIME-Version: 1.0
In-Reply-To: <20171004180428.GG1895@nanopsycho>
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

On 10/4/17 11:04 AM, Jiri Pirko wrote:
> Wed, Oct 04, 2017 at 05:35:46PM CEST, dsahern@gmail.com wrote:
>> On 10/3/17 11:38 PM, Jiri Pirko wrote:
>>> Wed, Oct 04, 2017 at 06:58:52AM CEST, dsahern@gmail.com wrote:
>>>> A number of bond_enslave errors are logged using the netdev_err API.
>>>> Return those messages to userspace via the extack facility.
>>>>
>>>> Signed-off-by: David Ahern <dsahern@gmail.com>
>>>> ---
>>>> drivers/net/bonding/bond_main.c | 12 ++++++++++++
>>>> 1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>>>> index bc92307c2082..6688dc9154e0 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -1348,12 +1348,15 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>>>>
>>>> 	/* already in-use? */
>>>> 	if (netdev_is_rx_handler_busy(slave_dev)) {
>>>> +		NL_SET_ERR_MSG(extack,
>>>> +			       "Device is in use and cannot be enslaved");
>>>
>>> Please don't do this kind of wrapping. Just let the string be on the
>>> same line.
>>>
>>
>> Ok, I will do that for bonding only since it is the existing style.
> 
> I don't believe you need to do this wrap for any code. Just don't wrap.
> General code stype says no wrap for strings :)
> 

I do not break / wrap strings; they need to be searchable. I assumed you
meant this is preferred for bonding:

NL_SET_ERR_MSG(extack, "Device is in use and cannot be enslaved");


over what I have done:

NL_SET_ERR_MSG(extack,
	       "Device is in use and cannot be enslaved");

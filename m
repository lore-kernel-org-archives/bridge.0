Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AjXmJ9EDJkVGniC4xcL/9u/xIj6KidR6CjRW12fBWJg=;
	b=gAsuYm+rhpYLVtr6keBMNh1bCYm3lia+eCZbI4EaKxrj/Re4gfXH5xWOiXAk1jDN5A
	B3U2z5p6NAmPA1T3y40phjbeccggeXROCi30c7dErpgZv1EThtmxkHZZi7C8Taf8wF/6
	YnZS2ma7Yea6aNT7WDXAHjfxaU43A44KskcMQ=
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
	<66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
	<20181124162541.GC24681@lunn.ch>
	<98A5C526-DBF7-40F0-9CB0-1C7AF7A5CF32@cumulusnetworks.com>
	<bc90dc53-b4fc-3725-7141-556e62f027f8@cumulusnetworks.com>
	<20181126093923.74c50dcb@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <56bb2f2e-4ed2-8ec4-0ea1-b00781a7e4b3@cumulusnetworks.com>
Date: Mon, 26 Nov 2018 19:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <20181126093923.74c50dcb@xeon-e3>
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
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew@lunn.ch>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, netdev@vger.kernel.org

On 26/11/2018 19:39, Stephen Hemminger wrote:
> On Sun, 25 Nov 2018 10:12:45 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> On 24/11/2018 18:46, nikolay@cumulusnetworks.com wrote:
>>> On 24 November 2018 18:25:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:  
>>>> On Sat, Nov 24, 2018 at 06:18:33PM +0200, nikolay@cumulusnetworks.com
>>>> wrote:  
>>>>> On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:  
>>>>>>> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id  
>>>> opt,  
>>>>>> bool on,  
>>>>>>> +		      struct netlink_ext_ack *extack)
>>>>>>> +{
>>>>>>> +	switch (opt) {
>>>>>>> +	default:
>>>>>>> +		/* shouldn't be called with unsupported options */
>>>>>>> +		WARN_ON(1);
>>>>>>> +		break;  
>>>>>>
>>>>>> So you return 0 here, meaning the br_debug() lower down will not
>>>>>> happen. Maybe return -EOPNOTSUPP?
>>>>>>  
>>>>>
>>>>> No, the idea here is that some option in the future might return an  
>>>> error.   
>>>>> This function cannot be called with unsupported option thus the warn.  
> 
>>
> 
> Please don't implement some part of the API until it is used (YAGNI).
> If do this kind of "someday will come" design the code will end up
> littered with dead ends.
> 

Is there anything unused ? This is just a precaution to catch future
offenders which forget to handle options where they're expected.
All of the API is used.


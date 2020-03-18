Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o5P//IGU0B1fbtQBBBaXBr2gpazCG2olY1bZnj6CAfM=;
 b=ct+ATNFVJrn3VKb5lby+6uwVXLapW/uZ/663YMP1KbQLzRN2o1ZXqiRFNIu30khQIZ
 UWHAZWFMLshnFevO9d3DKS9qWPSwyhLZ+hg3Zneb9f8Lgl6p/KAX1Wp0YYznxmTgilTl
 DJYOg14AfLdMbSmRp0bLXbtGxLZA2IkUfTDMc=
References: <20200318130325.100508-1-nikolay@cumulusnetworks.com>
 <20200318.164234.1141226942122598740.davem@davemloft.net>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <dfbabebc-6c04-0df9-6fb3-46fd875674d2@cumulusnetworks.com>
Date: Thu, 19 Mar 2020 01:49:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200318.164234.1141226942122598740.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: vlan: include stats in
 dumps if requested
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

On 3/19/20 1:42 AM, David Miller wrote:
> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date: Wed, 18 Mar 2020 15:03:25 +0200
> 
>> @@ -170,11 +170,13 @@ struct bridge_stp_xstats {
>>   /* Bridge vlan RTM header */
>>   struct br_vlan_msg {
>>   	__u8 family;
>> -	__u8 reserved1;
>> +	__u8 flags;
>>   	__u16 reserved2;
>>   	__u32 ifindex;
>>   };
> 
> I can't allow this for two reasons:
> 
> 1) Userspace explicitly initializing all members will now get a compile
>     failure on the reference to ->reserved1
> 
> 2) Userspace not initiailizing reserved fields, which worked previously,
>     might send in flags that trigger the new behavior.
> 
> Sorry, this is UAPI breakage.
> 

Hmm, fair enough. I'll respin with a new dump attribute which achieves the same.

Thanks.



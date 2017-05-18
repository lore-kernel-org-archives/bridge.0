Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qOpAp71cNBBN7liCW/MsADlMF0+H90QUtRk1xoE+8tA=;
	b=OJTz8L9cAgvRCfXJm5r8abpiJN7ipmU03uKX+itf5xcZvtaP2eEiBea+7SZxoK3kdT
	7Ku+qyELt0fBqj662lyVUCZUp7rma44eAcrpshaxpzVNZq7ZVOtQoDCSFZt+rcDe9enw
	4WQTB5umh8jmmR+VArZjScrddD3yECa2RBCTs=
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
	<20170517212709.6473-6-vivien.didelot@savoirfairelinux.com>
	<ee5d9736-72ec-f4fd-8e9b-2c4179687e16@cumulusnetworks.com>
	<87efvmf9fl.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <7f4c1954-bf78-9160-64d0-ed45cad388e6@cumulusnetworks.com>
Date: Thu, 18 May 2017 20:01:12 +0300
MIME-Version: 1.0
In-Reply-To: <87efvmf9fl.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [SPAM]Re: [PATCH net-next 5/6] net: bridge: get
 msgtype from nlmsghdr in mdb ops
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, netdev@vger.kernel.org
Cc: "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, kernel@savoirfairelinux.com, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On 5/18/17 6:53 PM, Vivien Didelot wrote:
> Hi Nikolay,
> 
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:
> 
>>> +	int msgtype = nlh->nlmsg_type;
>>
>> minor nits:
>> nlmsg_type is a u16, also please keep the order and arrange these from longest
>> to shortest
> 
> The reverse christmas tree \o/
> 
> Hum, __br_mdb_notify takes an int type, and struct nlmsghdr defines it
> as a __u16. Does u16 still make sense here instead of int?
> 
> 
> Thanks,
> 
>          Vivien
> 

Either way is fine as long as the value is unchanged, and since the rest of
the code uses an int then lets be consistent and leave it or if you decide 
change all.

Cheers,
  Nik

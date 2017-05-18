Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=1w91DxTkp75vYGuFjj2sPhLipB8w0WMs822ql2+XE58=;
	b=M9HNtqUfzJpQ6DZyDFeQuH/pV4JZZb92wRemrZ7t00BVqZW2Ej49FfczvS6JoLV8Vj
	3wykhtqudSZMROR5LAU79dP69n6V0xjtMZMXv9vl8HwIy02/yR2jPsOVuyI4QxscSHvD
	DUYj6FrD7sr3SOLFXgVAUQAA3Guo/vvUPmwkw=
References: <20170517212709.6473-1-vivien.didelot@savoirfairelinux.com>
	<20170517212709.6473-4-vivien.didelot@savoirfairelinux.com>
	<5d8f53ea-a9de-7c76-f088-48c5357cb2a2@cumulusnetworks.com>
	<877f1edwxp.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1211f3cb-c5f5-a9bd-638b-bfcb99fd1bed@cumulusnetworks.com>
Date: Thu, 18 May 2017 18:25:11 +0300
MIME-Version: 1.0
In-Reply-To: <877f1edwxp.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/6] net: bridge: break if
	__br_mdb_del fails
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

On 5/18/17 6:08 PM, Vivien Didelot wrote:
> Hi Nikolay,
> 
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> writes:
> 
>>>    			err = __br_mdb_del(br, entry);
>>> -			if (!err)
>>> -				__br_mdb_notify(dev, p, entry, RTM_DELMDB);
>>> +			if (err)
>>> +				break;
>>> +			__br_mdb_notify(dev, p, entry, RTM_DELMDB);
>>>    		}
>>>    	} else {
>>>    		err = __br_mdb_del(br, entry);
>>>
>>
>> This can potentially break user-space scripts that rely on the best-effort
>> behaviour, this is the normal "delete without vid & enabled vlan filtering".
>> You can check the fdb delete code which does the same, this was intentional.
>>
>> You can add an mdb entry without a vid to all vlans, add a vlan and then try
>> to remove it from all vlans where it is present - with this patch obviously
>> that will fail at the new vlan.
> 
> OK good to know. That intention wasn't obvious. I can make __br_mdb_del
> return void instead? What about the rest of the patchset if I do so?
> 
> Thanks,
> 
>          Vivien
> 

If you make it return void we will not be able to return proper error value
when doing a single operation (the else case). About the rest I see only some
minor style issues, I'll comment on the respective patches. Another minor nit is 
using switch() instead of if/else for the message types but that is really up to 
you, I don't mind either way. :-)

Cheers,
  Nik



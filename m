Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JmkLVMbRADHCFGoxeIs/xrYSG/wZbOh0NhN16DEfSy8=;
	b=K7pTYh/TRjArsLcxyUTw2696HyELcxWN0RupP+snl46nRgGPyYeFY5uysbhh61QJuH
	1pPT9azavv0PzbxE7zO6+Cp4r13xQgSm7mii04aheuodknbgj26nFVJ/dTqFua9wIdR3
	ncts978sJHAE1KKPHHrY4KN0g9H6wn8qkg4GmI58oE7jTdXAO7RgHG5KOZX/EGuDUvSm
	jNbkRmSjr1NUlaTjWLC+1xhPpAmEOZoqxw+Mc8MRVTz8LGQqM3C/3+qU6h89V5Fqhh6D
	opy7GHwVHyTZ/TsaASxBjkfrbomRPlQG1bKK/cN9b1VgnrSo3pA+Il5zCY7y3NHz6tXP
	JuTg==
From: Florian Fainelli <f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
	<20190212.095030.1445077555795164973.davem@davemloft.net>
	<6ff1b9c2-1206-f568-8556-28efe852dd08@gmail.com>
Message-ID: <2c1af87e-5721-c51d-b7f7-6f5c0ef2566d@gmail.com>
Date: Tue, 12 Feb 2019 13:35:37 -0800
MIME-Version: 1.0
In-Reply-To: <6ff1b9c2-1206-f568-8556-28efe852dd08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/3] Remove getting
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

On 2/12/19 9:54 AM, Florian Fainelli wrote:
> On 2/12/19 9:50 AM, David Miller wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> Date: Mon, 11 Feb 2019 13:17:46 -0800
>>
>>> AFAICT there is no code that attempts to get the value of the attribute
>>> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
>>> switchdev_port_attr_set().
>>>
>>> This is effectively no doing anything and it can slow down future work
>>> that tries to make modifications in these areas so remove that.
>>
>> Series applied.
>>
>>> David, there should be no dependency with previous patch series, but
>>> again, feedback from Ido and Jiri would be welcome in case this was
>>> added for a reason.
>>
>> Ok, is there going to be another respin of that switchdev_ops removal
>> series?
> 
> Yes, I will be working on a v5 which addresses Ido's feedback in the
> next hours.

David, looks like I managed to introduce a build failure with
rocker_ofdpa.c, sorry about that, I will send a follow-up immediately.
-- 
Florian

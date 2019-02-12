Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ArMxNOx8F5Atf+Z9ivUZEyZ+eQp3CyRSZZUJGiMx2lE=;
	b=MjC8kbBXDU4RtRo9iFRzMLCChgicJUbUcYxXMPS3+Vvoa4XijuVau/gWCRnCjo28hj
	WJDYDLwfLzxKUIn1anZryKu8XK60WE65lG3Dg6YBiqkWv7vcSaRqxCvtgKbffW5AdEb3
	LUKxEg7WKDXieodMbiFOi78a11Lc/OdEaIm5GT/4JCx32JgLy9axMQhLCnIFgCn9ZWhA
	UCOnKMDjaTIhgEI682I20aURm3YQwxG8rFso9CU6VotqYyxMqG8wiP3PgMB/rfzOoz4R
	mGp0oG7Zw6eROAGoBCW8NFjqXQzb+03KIPjVL9p/1p9Nh/GkH7Qcx1N2SjuuT3bVz277
	WqdA==
References: <20190211211749.19847-1-f.fainelli@gmail.com>
	<20190212.095030.1445077555795164973.davem@davemloft.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6ff1b9c2-1206-f568-8556-28efe852dd08@gmail.com>
Date: Tue, 12 Feb 2019 09:54:24 -0800
MIME-Version: 1.0
In-Reply-To: <20190212.095030.1445077555795164973.davem@davemloft.net>
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

On 2/12/19 9:50 AM, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Mon, 11 Feb 2019 13:17:46 -0800
> 
>> AFAICT there is no code that attempts to get the value of the attribute
>> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
>> switchdev_port_attr_set().
>>
>> This is effectively no doing anything and it can slow down future work
>> that tries to make modifications in these areas so remove that.
> 
> Series applied.
> 
>> David, there should be no dependency with previous patch series, but
>> again, feedback from Ido and Jiri would be welcome in case this was
>> added for a reason.
> 
> Ok, is there going to be another respin of that switchdev_ops removal
> series?

Yes, I will be working on a v5 which addresses Ido's feedback in the
next hours.
-- 
Florian

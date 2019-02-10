Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KNY5zECgExW4ILR3xsKh1LqdbsCQIgK+wkOcJfKWtQU=;
	b=I1JWArZZLEAeyX7uRJnrOmzKAWB0MP5w+lS1hRJdvZApoIXzBSH1D3uJZF1xfhjT0B
	I8YTfAOX58SZC1SAMU//jDMPNXHV1jeIoXOkHSs2mvE7OCflpb4HkOoRU6NVdMuZlaG1
	LMuIEf24jj0FETNSImb2shGX9bG+QByboxFpqKc/8ZV+/mL+BU2Dj3yt5BrhXon7vuh3
	vnpP/chK1zmxBNzKQHbxwvZJnw+UUGrmbheJmq51rjB7ttEnqDx47UDFEkIynmZDK6z5
	cs1sclqTfV0u1x5WVrItSft7caX0KCi3xG7knhB40YVACP09RUC+7zkpKOkZUL1FOPuV
	lcNg==
References: <20190210175105.31629-1-f.fainelli@gmail.com>
	<20190210175105.31629-7-f.fainelli@gmail.com>
	<20190210190501.GA26726@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <73a10fbb-7689-74a7-3fbf-076f8dc9d76f@gmail.com>
Date: Sun, 10 Feb 2019 11:34:14 -0800
MIME-Version: 1.0
In-Reply-To: <20190210190501.GA26726@splinter>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>

Le 2/10/19 à 11:05 AM, Ido Schimmel a écrit :
> On Sun, Feb 10, 2019 at 09:50:55AM -0800, Florian Fainelli wrote:
>> Now that all switchdev drivers have been converted to checking the
>> bridge port flags during the prepare phase of the
>> switchdev_port_attr_set(), we can move straight to trying to set the
>> desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
>>
>> Acked-by: Jiri Pirko <jiri@mellanox.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  net/bridge/br_switchdev.c | 20 +++-----------------
>>  1 file changed, 3 insertions(+), 17 deletions(-)
>>
>> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
>> index db9e8ab96d48..939f300522c5 100644
>> --- a/net/bridge/br_switchdev.c
>> +++ b/net/bridge/br_switchdev.c
>> @@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
>>  {
>>  	struct switchdev_attr attr = {
>>  		.orig_dev = p->dev,
>> -		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
>> +		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
>> +		.flags = SWITCHDEV_F_DEFER,
> 
> How does this work? You defer the operation, so the driver cannot veto
> it. This is why we have SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
> which is not deferred.

I missed that indeed, how would you feel about splitting the attribute
setting into different phases:

- checking that the attribute setting is supported (caller context, so
possibly atomic)
- allocating and committing resources (deferred context)

For pretty much any DSA driver, we will have to be in sleepable context
anyway because of MDIO, SPI, I2C, whatever transport layer.

Not sure how to best approach this now...
-- 
Florian

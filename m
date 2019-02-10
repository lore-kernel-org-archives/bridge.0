Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9lQXsszTcMVqFZE6VT/IIy4/5gNOs/t04egR9fl2aYo=;
	b=SO7ykiu8H9vNI4xtmQdiEUBVFMhlQaE5k6aH9a3x6jFYWj/4LaOQMPUXJuKDW5OzRw
	rSvp1wTpoJhxd49sOsQdNVHhnbl+2BAnV+nbwx21WdKJ6mJLeSI48uvNF0P20KviWwK8
	RkipPN++2uJtcWmJrN7p4cw2VuslZxFAY/tgzRyYoVcmhxnaQrMQnXHCibtGcVy1wUNT
	KEupL3IUvNaDq/PlhcTUr5RcjR53KT3DUkzh+3WBKc9TCwDEGbMQFYlWYkuaIgrF3CRG
	gUhlH570T2WpTN8koc+QBVfbaIPkkfkhiobiQTjZLSitE4rz7Oyn61qQ2AKswI5IGp5w
	LGKA==
References: <20190209003248.31088-1-f.fainelli@gmail.com>
	<20190209003248.31088-11-f.fainelli@gmail.com>
	<20190209182147.GQ2353@nanopsycho>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a4d00850-deac-20e7-7c9f-ef41edf5a85a@gmail.com>
Date: Sat, 9 Feb 2019 20:20:30 -0800
MIME-Version: 1.0
In-Reply-To: <20190209182147.GQ2353@nanopsycho>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 10/16] rocker: Handle
	SWITCHDEV_PORT_ATTR_SET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, netdev@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Le 2/9/19 à 10:21 AM, Jiri Pirko a écrit :
> Sat, Feb 09, 2019 at 01:32:42AM CET, f.fainelli@gmail.com wrote:
>> Following patches will change the way we communicate getting or setting
> 
> Just "setting", no "getting".
> 
> 
>> a port's attribute and use a blocking notifier to perform those tasks.
>>
>> Prepare rocker to support receiving notifier events targeting
>> SWITCHDEV_PORT_ATTR_SET and simply translate that into the existing
>> rocker_port_attr_set call.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> drivers/net/ethernet/rocker/rocker_main.c | 20 ++++++++++++++++++++
>> 1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
>> index ff3f14504f4f..f10e4888ecff 100644
>> --- a/drivers/net/ethernet/rocker/rocker_main.c
>> +++ b/drivers/net/ethernet/rocker/rocker_main.c
>> @@ -2811,6 +2811,24 @@ rocker_switchdev_port_obj_event(unsigned long event, struct net_device *netdev,
>> 	return notifier_from_errno(err);
>> }
>>
>> +static int
>> +rocker_switchdev_port_attr_event(unsigned long event, struct net_device *netdev,
>> +				 struct switchdev_notifier_port_attr_info
>> +				 *port_attr_info)
>> +{
>> +	int err = -EOPNOTSUPP;
>> +
>> +	switch (event) {
>> +	case SWITCHDEV_PORT_ATTR_SET:
> 
> Do you expect some other event to be handled in
> rocker_switchdev_port_attr_event()? Because you have SWITCHDEV_PORT_ATTR_SET
> selected in case here and in rocker_switchdev_blocking_event.
> Perhaps you can rename rocker_switchdev_port_attr_event() to
> rocker_switchdev_port_attr_set_event() and avoid this switchcase.

That's a good point, I have PORT_ATTR_{GET_SET} initially which was the
reason for the switch/case statement, will change it according to your
suggestion. Thanks!
-- 
Florian

Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vx/WSBXnhReQ11bAByZd5aM5wpYJK6NbILB5Q6x+bNs=;
	b=eAIUJfiyEplPuCEgqfXclCCwbQfgY3kmF1h0Dp6S+dTg/WdJ1lAoZShy9NRTHzIz1uYe825LwdQSR9vO5x09WKrGUAicaHdz+dHab+1P2ZP9etoO70aPwi3/W6y8F0EddRE0pgVXvgjHEy/VcOVG6d3yxguX6Q7h3ssW484ydn8=
From: Petr Machata <petrm@mellanox.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
	<877enrzp42.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Date: Fri, 25 May 2018 20:00:37 +0300
In-Reply-To: <877enrzp42.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
	(Vivien Didelot's message of "Fri, 25 May 2018 12:17:33 -0400")
Message-ID: <wihwovrfz62.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 6/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:

>> +	} else {
>> +		err = br_switchdev_port_obj_add(dev, v->vid, flags);
>> +		if (err && err != -EOPNOTSUPP)
>> +			goto out;
>>  	}
>
> Except that br_switchdev_port_obj_add taking vid and flags arguments
> seems confusing to me, the change looks good:

I'm not sure what you're aiming at. Both VID and flags are sent with the
notification, so they need to be passed on to the function somehow. Do
you have a counterproposal for the API?

Thanks,
Petr

Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
In-Reply-To: <wihwovrfz62.fsf@dev-r-vrt-156.mtr.labs.mlnx>
References: <cover.1527173527.git.petrm@mellanox.com>
	<b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
	<877enrzp42.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
	<wihwovrfz62.fsf@dev-r-vrt-156.mtr.labs.mlnx>
Date: Sat, 26 May 2018 10:54:25 -0400
Message-ID: <87y3g6mpr2.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

Hi Petr,

Petr Machata <petrm@mellanox.com> writes:

> Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:
>
>>> +	} else {
>>> +		err = br_switchdev_port_obj_add(dev, v->vid, flags);
>>> +		if (err && err != -EOPNOTSUPP)
>>> +			goto out;
>>>  	}
>>
>> Except that br_switchdev_port_obj_add taking vid and flags arguments
>> seems confusing to me, the change looks good:
>
> I'm not sure what you're aiming at. Both VID and flags are sent with the
> notification, so they need to be passed on to the function somehow. Do
> you have a counterproposal for the API?

I'm only questioning the code organization here, not the functional
aspect which I do agree with. What I'm saying is that you name a new
switchdev helper br_switchdev_port_OBJ_add, which takes VLAN arguments
(vid and flags.) How would you call another eventual helper taking MDB
arguments, br_switchdev_port_OBJ_add again? So something like
br_switchdev_port_VLAN_add would be more intuitive.

At the same time there's an effort to centralize all switchdev helpers
of the bridge layer (i.e. the software -> hardware bridge calls) into
net/bridge/br_switchdev.c, so that file would be more adequate.

You may discard my comments but I think it'd be beneficial to us all to
finally keep a bit of consistency in that bridge layer code.


Thanks,

        Vivien

Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=fJ7ZyXPy1IM7uzU+eCeBhG+Ve/VsIicdbs5mtyTYDSY=;
	b=d1IXxq/upaxs3WNTMrqK4AD4Kefl/pgLYk7IcBfzAwf0xsMFbXcFZKETKbAqpVGT79Xjk1vMKwVJexR4DIK1h5hSmbberY5oMlxoGdvnqezx+uQoGkb6ab6W2D2zNCc/y3T7Mkeh5vkxybjK1C+f7XTVFATfDhK68wmXdNlfXKI=
From: Petr Machata <petrm@mellanox.com>
References: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
	<20180530.124215.898586103229215718.davem@davemloft.net>
Date: Thu, 31 May 2018 01:03:05 +0300
In-Reply-To: <20180530.124215.898586103229215718.davem@davemloft.net> (David
	Miller's message of "Wed, 30 May 2018 12:42:15 -0400")
Message-ID: <wih8t80er8m.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

David Miller <davem@davemloft.net> writes:

> From: Petr Machata <petrm@mellanox.com>
> Date: Mon, 28 May 2018 17:44:16 +0200
>
>> Callers of br_fdb_find() need to hold the hash lock, which
>> br_fdb_find_port() doesn't do. Add the missing lock/unlock
>> pair.
>> 
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>
> If all of the these uses of br_fdb_find_port() are safe, then it
> should use the RCU fdb lookup variant.
>
> So I basically agree with Stephen that this locking doesn't make any
> sense.
>
> The lock is needed when you are going to add or delete an FDB entry.
>
> Here we are doing a lookup and returning a device pointer via the FDB
> entry found in the lookup.
>
> The RTNL assertion assures that the device returned won't disappear.
>
> If the device can disappear, the spinlock added by this patch doesn't
> change that at all.

OK, I'll take another look at this.

Thanks,
Petr

Date: Fri, 29 May 2009 01:52:32 -0700 (PDT)
Message-Id: <20090529.015232.113333227.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A1E7887.4000102@gmail.com>
References: <20090527135351.GD1652@psychotron.englab.brq.redhat.com>
	<20090528110459.GE22391@psychotron.englab.brq.redhat.com>
	<4A1E7887.4000102@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] bonding: allow bond in mode
 balance-alb to work properly in bridge -try4.3
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eric.dumazet@gmail.com
Cc: fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, oleg@redhat.com, mschmidt@redhat.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 28 May 2009 13:41:59 +0200

> Jiri Pirko a =E9crit :
>> [PATCH net-next] bonding: allow bond in mode balance-alb to work pro=
perly in bridge -try4.3
>> =

>> (updated)
>> changes v4.2 -> v4.3
>> - memcpy the address always, not just in case it differs from master=
->dev_addr
>> - compare_ether_addr_64bits() is not used so there is no direct need=
 to make new
>>   header file (I think it would be good to have bond stuff in separa=
te file
>>   anyway).
> =

> Yes, this could be done in a future cleanup patch.
> I find this (short) version easier to review for a new feature.
> =

> Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>

Applied, thanks everyone.

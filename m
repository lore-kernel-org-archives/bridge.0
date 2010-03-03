Date: Wed, 03 Mar 2010 01:16:33 -0800 (PST)
Message-Id: <20100303.011633.133428196.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1267596544.2839.71.camel@edumazet-laptop>
References: <1267553173.2839.9.camel@edumazet-laptop>
	<20100302153209.74742a96@nehalam>
	<1267596544.2839.71.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] bridge: per-cpu packet statistics (v3)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Wed, 03 Mar 2010 07:09:04 +0100

> Le mardi 02 mars 2010 =E0 15:32 -0800, Stephen Hemminger a =E9crit :
>> The shared packet statistics are a potential source of slow down
>> on bridged traffic. Convert to per-cpu array, but only keep those
>> statistics which change per-packet.
>> =

>> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
>> =

> =

> Thanks Stephen !
> =

> Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>

This is fine but needs to go into the next merge window, not
this one.

Bug fixes only now.

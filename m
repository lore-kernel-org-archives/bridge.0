Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C8CB4038E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EE3F4041C
MIME-Version: 1.0
Date: Thu, 20 Oct 2022 21:59:03 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221020132538.reirrskemcjwih2m@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
Message-ID: <77c2b6507fd267cefdaf74e53c2bd325@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v8 net-next 10/12] net: dsa: mv88e6xxx:
 mac-auth/MAB implementation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On 2022-10-20 15:25, Vladimir Oltean wrote:
>> +
>> +#include <net/switchdev.h>
>> +#include <linux/list.h>
>> +#include "chip.h"
>> +#include "global1.h"
>> +#include "switchdev.h"
>> +
>> +static void mv88e6xxx_atu_locked_entry_purge(struct 
>> mv88e6xxx_atu_locked_entry *ale,
>> +					     bool notify, bool take_nl_lock)
>> +{
>> +	struct switchdev_notifier_fdb_info info = {
>> +		.addr = ale->mac,
>> +		.vid = ale->vid,
>> +		.locked = true,
>> +		.offloaded = true,
>> +	};
>> +	struct mv88e6xxx_atu_entry entry;
>> +	struct net_device *brport;
>> +	struct dsa_port *dp;
>> +
>> +	entry.portvec = MV88E6XXX_G1_ATU_DATA_PORT_VECTOR_NO_EGRESS;
>> +	entry.state = MV88E6XXX_G1_ATU_DATA_STATE_UC_UNUSED;
>> +	entry.trunk = false;
>> +	ether_addr_copy(entry.mac, ale->mac);
>> +
>> +	mv88e6xxx_reg_lock(ale->chip);
>> +	mv88e6xxx_g1_atu_loadpurge(ale->chip, ale->fid, &entry);
>> +	mv88e6xxx_reg_unlock(ale->chip);
>> +
>> +	dp = dsa_to_port(ale->chip->ds, ale->port);
>> +
>> +	if (notify) {
>> +		if (take_nl_lock)
>> +			rtnl_lock();
> 
> Is this tested with lockdep? I see the function is called with other
> locks held (p->ale_list_lock). Isn't there a lock inversion anywhere?
> Locks always need to be taken in the same order, and rtnl_lock is a
> pretty high level lock, not exactly the kind you could take just like
> that.
> 

I am very sure that there is no lock inversions or double locks taken.
It is only in the clean-up from time-out of driver locked entries that
the nl lock needs to be taken (as the code reveals). In all other
instances, the nl lock is already taken as far as this implementation 
goes.

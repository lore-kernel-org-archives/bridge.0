Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CD2442222
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A02CA4221E
MIME-Version: 1.0
Date: Thu, 20 Oct 2022 22:20:50 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221020132538.reirrskemcjwih2m@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
Message-ID: <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
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
>> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c 
>> b/drivers/net/dsa/mv88e6xxx/chip.c
>> index 352121cce77e..71843fe87f77 100644
>> --- a/drivers/net/dsa/mv88e6xxx/chip.c
>> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
>> @@ -42,6 +42,7 @@
>>  #include "ptp.h"
>>  #include "serdes.h"
>>  #include "smi.h"
>> +#include "switchdev.h"
>> 
>>  static void assert_reg_lock(struct mv88e6xxx_chip *chip)
>>  {
>> @@ -924,6 +925,13 @@ static void mv88e6xxx_mac_link_down(struct 
>> dsa_switch *ds, int port,
>>  	if (err)
>>  		dev_err(chip->dev,
>>  			"p%d: failed to force MAC link down\n", port);
>> +	else
>> +		if (mv88e6xxx_port_is_locked(chip, port)) {
>> +			err = mv88e6xxx_atu_locked_entry_flush(ds, port);
>> +			if (err)
>> +				dev_err(chip->dev,
>> +					"p%d: failed to clear locked entries\n", port);
>> +		}
> 
> This would not have been needed if dsa_port_set_state() would have
> called dsa_port_fast_age().
> 
> Currently it only does that if dp->learning is true. From previous
> conversations I get the idea that with MAB, port learning will be 
> false.
> But I don't understand why; isn't MAB CPU-assisted learning? I'm 
> looking
> at the ocelot hardware support for this and I think it could be
> implemented using a similar mechanism, but I certainly don't want to 
> add
> more workarounds such as this in other drivers.
> 
> Are there any other ways to implement MAB other than through CPU
> assisted learning?
> 
> We could add one more dp->mab flag which tracks the "mab" brport flag,
> and extend dsa_port_set_state() to also call dsa_port_fast_age() in 
> that
> case, but I want to make sure there isn't something extremely obvious
> I'm missing about the "learning" flag.
> 

In general locked ports block traffic from a host based on if there is a
FDB entry or not. In the non-offloaded case, there is only CPU assisted
learning, so the normal learning mechanism has to be disabled as any
learned entry will open the port for the learned MAC,vlan.
Thus learning is off for locked ports, which of course includes MAB.

So the 'learning' is based on authorizing MAC,vlan addresses, which
is done by userspace daemons, e.g. hostapd or what could be called
mabd.

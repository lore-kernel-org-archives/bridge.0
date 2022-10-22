Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C59383E1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E7CC83046
MIME-Version: 1.0
Date: Sat, 22 Oct 2022 09:31:06 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221020132538.reirrskemcjwih2m@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
Message-ID: <a0269818b270ad0537b991bd98725260@kapio-technology.com>
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
>>  	if (flags.mask & BR_LEARNING) {
>>  		bool learning = !!(flags.val & BR_LEARNING);
>>  		u16 pav = learning ? (1 << port) : 0;
>> 
>> +		mv88e6xxx_reg_lock(chip);
>>  		err = mv88e6xxx_port_set_assoc_vector(chip, port, pav);
>> +		mv88e6xxx_reg_unlock(chip);
>>  		if (err)
>>  			goto out;
>>  	}
>> @@ -6563,8 +6593,10 @@ static int mv88e6xxx_port_bridge_flags(struct 
>> dsa_switch *ds, int port,
>>  	if (flags.mask & BR_FLOOD) {
>>  		bool unicast = !!(flags.val & BR_FLOOD);
>> 
>> +		mv88e6xxx_reg_lock(chip);
>>  		err = chip->info->ops->port_set_ucast_flood(chip, port,
>>  							    unicast);
>> +		mv88e6xxx_reg_unlock(chip);
>>  		if (err)
>>  			goto out;
>>  	}
>> @@ -6572,8 +6604,10 @@ static int mv88e6xxx_port_bridge_flags(struct 
>> dsa_switch *ds, int port,
>>  	if (flags.mask & BR_MCAST_FLOOD) {
>>  		bool multicast = !!(flags.val & BR_MCAST_FLOOD);
>> 
>> +		mv88e6xxx_reg_lock(chip);
>>  		err = chip->info->ops->port_set_mcast_flood(chip, port,
>>  							    multicast);
>> +		mv88e6xxx_reg_unlock(chip);
>>  		if (err)
>>  			goto out;
>>  	}
>> @@ -6581,20 +6615,34 @@ static int mv88e6xxx_port_bridge_flags(struct 
>> dsa_switch *ds, int port,
>>  	if (flags.mask & BR_BCAST_FLOOD) {
>>  		bool broadcast = !!(flags.val & BR_BCAST_FLOOD);
>> 
>> +		mv88e6xxx_reg_lock(chip);
>>  		err = mv88e6xxx_port_broadcast_sync(chip, port, broadcast);
>> +		mv88e6xxx_reg_unlock(chip);
>>  		if (err)
>>  			goto out;
>>  	}
>> 
>> +	if (flags.mask & BR_PORT_MAB) {
>> +		chip->ports[port].mab = !!(flags.val & BR_PORT_MAB);
>> +
>> +		if (!chip->ports[port].mab)
>> +			err = mv88e6xxx_atu_locked_entry_flush(ds, port);
>> +		else
>> +			err = 0;
> 
> Again, dsa_port_fast_age() is also called when dp->learning is turned
> off in dsa_port_bridge_flags(). I don't want to see the mv88e6xxx 
> driver
> doing this manually.
> 

But I think it should be so that turning MAB off will clear the ALE 
entries
regardless, as the port can continue to be locked and needing port 
association,
or you want them to just age out normally in that case, thus lingering 
for
up to bridge ageing time?

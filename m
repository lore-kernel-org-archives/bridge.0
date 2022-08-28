Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36E4060A8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48073608A5
MIME-Version: 1.0
Date: Sun, 28 Aug 2022 13:27:08 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ywo8PONgDW/lUj+X@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-3-netdev@kapio-technology.com>
 <Ywo8PONgDW/lUj+X@shredder>
Message-ID: <4206d70598694689acf6b6ec30ef6523@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 2/6] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-08-27 17:46, Ido Schimmel wrote:
> On Fri, Aug 26, 2022 at 01:45:34PM +0200, Hans Schultz wrote:
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index 7dcdc97c0bc3..437945179373 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -247,7 +247,10 @@ struct switchdev_notifier_fdb_info {
>>  	const unsigned char *addr;
>>  	u16 vid;
>>  	u8 added_by_user:1,
>> +	   sticky:1,
> 
> If mv88e6xxx reports entries with 'is_local=1, locked=1, blackhole=1',
> then the 'sticky' bit can be removed for now (we will need it some day
> to support sticky entries notified from the bridge). This takes care of
> the discrepancy Nik mentioned here:
> 
> https://lore.kernel.org/netdev/d1de0337-ae16-7dca-b212-1a4e85129c31@blackwall.org/
> 
>>  	   is_local:1,
>> +	   locked:1,
>> +	   blackhole:1,
>>  	   offloaded:1;
>>  };

Right!

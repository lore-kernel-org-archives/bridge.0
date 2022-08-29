Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C34640BFB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EA1640BE8
MIME-Version: 1.0
Date: Mon, 29 Aug 2022 13:09:12 +0200
From: netdev@kapio-technology.com
In-Reply-To: <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-2-netdev@kapio-technology.com>
 <e9eb5b72-073a-f182-13b7-37fc53611d5f@blackwall.org>
Message-ID: <d90a67c5ca6035f7ae75b7bada430e03@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 1/6] net: bridge: add locked entry
 fdb flag to extend locked port feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

> On 2022-08-27 13:30, Nikolay Aleksandrov wrote:

>> @@ -879,6 +888,10 @@ void br_fdb_update(struct net_bridge *br, struct 
>> net_bridge_port *source,
>>  						      &fdb->flags)))
>>  					clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
>>  						  &fdb->flags);
>> +				if (source->flags & BR_PORT_MAB)
>> +					set_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
>> +				else
>> +					clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
> Please add a test for that bit and only then change it.
> 

Something like this?

@@ -749,6 +756,12 @@ void br_fdb_update(struct net_bridge *br, struct 
net_bridge_port *source,
                                                       &fdb->flags)))
                                         
clear_bit(BR_FDB_ADDED_BY_EXT_LEARN,
                                                   &fdb->flags);
+                               if 
(unlikely(test_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags))) {
+                                       if (!(source->flags & 
BR_PORT_MAB))
+                                               
clear_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
+                               } else
+                                       if (source->flags & BR_PORT_MAB)
+                                               
set_bit(BR_FDB_ENTRY_LOCKED, &fdb->flags);
                         }

                         if (unlikely(test_bit(BR_FDB_ADDED_BY_USER, 
&flags)))



Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BFD96FB14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B97A86FABF
MIME-Version: 1.0
Date: Thu, 20 Oct 2022 21:34:05 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Y1FHuXE+X/V9aRvh@shredder>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-3-netdev@kapio-technology.com>
 <Y1FHuXE+X/V9aRvh@shredder>
Message-ID: <40edb67ac71ba7eef428c8366753ae94@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v8 net-next 02/12] net: bridge: add blackhole
 fdb entry flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On 2022-10-20 15:06, Ido Schimmel wrote:
> On Tue, Oct 18, 2022 at 06:56:09PM +0200, Hans J. Schultz wrote:
>> Add a 'blackhole' fdb flag, ensuring that no forwarding from any port
>> to a destination MAC that has a FDB entry with this flag on will 
>> occur.
>> The packets will thus be dropped.
>> 
>> When the blackhole fdb flag is set, the 'local' flag will also be 
>> enabled
>> as blackhole entries are not associated with any port.
> 
> It reads as if the kernel will enable the 'local' flag automatically,
> which is not true anymore. The bridge driver enforces that
> 'NUD_PERMANENT' is set if 'NTF_EXT_BLACKHOLE' is specified.
> 
>> 
>> Thus the command will be alike to:
>> bridge fdb add MAC dev br0 local blackhole
>> 
>> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> 
> Looks OK to me. See one comment below.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]
> 
>> @@ -1140,7 +1148,7 @@ static int __br_fdb_add(struct ndmsg *ndm, 
>> struct net_bridge *br,
>>  		err = br_fdb_external_learn_add(br, p, addr, vid, true);
>>  	} else {
>>  		spin_lock_bh(&br->hash_lock);
>> -		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
>> +		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, ext_flags, 
>> nfea_tb);
> 
> I believe the preference is to wrap to 80 columns when possible.

Ok, I only have knowledge of 100 columns as a limit.


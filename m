Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82A46817A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39B89831AE
MIME-Version: 1.0
Date: Mon, 29 Aug 2022 14:04:42 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Ywyj1VF1wlYqlHb6@shredder>
References: <20220826114538.705433-1-netdev@kapio-technology.com>
 <20220826114538.705433-7-netdev@kapio-technology.com>
 <YwpgvkojEdytzCAB@shredder>
 <7654860e4d7d43c15d482c6caeb6a773@kapio-technology.com>
 <YwxtVhlPjq+M9QMY@shredder>
 <2967ccc234bb672f5440a4b175b73768@kapio-technology.com>
 <Ywyj1VF1wlYqlHb6@shredder>
Message-ID: <9e1a9eb218bbaa0d36cb98ff5d4b97d7@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
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

On 2022-08-29 13:32, Ido Schimmel wrote:
>> The final decision on this rests with you I would say.
> 
> If the requirement for this feature (with or without MAB) is to work
> with dynamic entries (which is not what is currently implemented in the
> selftests), then learning needs to be enabled for the sole reason of
> refreshing the dynamic entries added by user space. That is, updating
> 'fdb->updated' with current jiffies value.
> 
> So, is this the requirement? I checked the hostapd fork you posted some
> time ago and I get the impression that the answer is yes [1], but I 
> want
> to verify I'm not missing something.
> 
> [1] 
> https://github.com/westermo/hostapd/commit/95dc96f9e89131b2319f5eae8ae7ac99868b7cd0#diff-338b6fad34b4bdb015d7d96930974bd96796b754257473b6c91527789656d6edR11
> 
> 

I cannot say that it is a requirement with respect to the bridge 
implementation, but it is with the driver implementation. But you are 
right that it is to be used with dynamic entries.

>> > # ip link set dev swp1 up
>> > # ip link set dev swp2 up
>> > # ip link set dev br0 up
>> >
>> > 2. Assuming h1 behind swp1 was authorized using 802.1X:
>> >
>> > # bridge fdb replace $H1_MAC dev swp1 master dynamic
>> 
>> With the new MAB flag 'replace' is not needed when MAB is not enabled.
> 
> Yes, but replace works in both cases.
> 

Yes, of course.

>> 
>> >
>> > 3. Assuming 802.1X authentication failed for h2 behind swp2, enable MAB:
>> >
>> > # bridge link set dev swp2 mab on
>> >
>> > 4. Assuming $H2_MAC is in our allow list:
>> >
>> > # bridge fdb replace $H2_MAC dev swp2 master dynamic
>> >
>> > Learning is on in order to refresh the dynamic entries that user space
>> > installed.
>> 
>> Yes, port association is needed for those reasons. :-)
> 
> Given that the current tests use "static" entries that cannot age, is
> there a reason to have "learning on"?
> 

Port association is needed for MAB to work at all on mv88e6xxx, but for 
802.1X port association is only needed for dynamic ATU entries.

>> 
>> >
>> > (*) Need to add support for this option in iproute2. Already exposed
>> > over netlink (see 'IFLA_BR_MULTI_BOOLOPT').
>> 
>> Should I do that in this patch set?
> 
> No, I'm saying that this option is already exposed over netlink, but
> missing iproute2 support. No kernel changes needed.

Oh yes, I meant in the iproute2 accompanying patch set to this one?

Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F15883339
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85D5783337
MIME-Version: 1.0
Date: Tue, 18 Oct 2022 16:29:05 +0200
From: netdev@kapio-technology.com
In-Reply-To: <Y0gbVoeV/e6wzlbM@shredder>
References: <20221009174052.1927483-1-netdev@kapio-technology.com>
 <20221009174052.1927483-4-netdev@kapio-technology.com>
 <Y0gbVoeV/e6wzlbM@shredder>
Message-ID: <3246a8d773146f0cbe39dd8ec182efaf@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v7 net-next 3/9] net: switchdev: add support
 for offloading of the FDB locked flag
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

On 2022-10-13 16:06, Ido Schimmel wrote:
> On Sun, Oct 09, 2022 at 07:40:46PM +0200, Hans J. Schultz wrote:
>> Add support for offloading of the MAB/MacAuth feature flag and the FDB
>> locked flag which is used by the Mac-Auth/MAB feature.
>> 
>> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
>> ---
>>  include/net/dsa.h         |  2 ++
>>  include/net/switchdev.h   |  1 +
>>  net/bridge/br.c           |  4 ++--
>>  net/bridge/br_fdb.c       | 12 ++++++++++--
>>  net/bridge/br_private.h   |  2 +-
>>  net/bridge/br_switchdev.c |  3 ++-
>>  net/dsa/dsa_priv.h        |  6 ++++--
>>  net/dsa/port.c            | 10 ++++++----
>>  net/dsa/slave.c           | 10 ++++++++--
>>  net/dsa/switch.c          | 16 ++++++++--------
>>  10 files changed, 44 insertions(+), 22 deletions(-)
> 
> There is more than one logical change here. I suggest splitting it to
> make review easier:
> 
> 1. A patch allowing the bridge driver to install locked entries 
> notified
> from device drivers. These changes:
> 
> include/net/switchdev.h   |  1 +
> net/bridge/br.c           |  4 ++--
> net/bridge/br_fdb.c       | 12 ++++++++++--
> net/bridge/br_private.h   |  2 +-
> 
> And the br_switchdev_fdb_populate() hunk
> 
> 2. A patch allowing DSA core to report locked entries to the bridge
> driver

2. This requires no code in the DSA layer as the bridge listens directly 
to the
kernel switchdev notifications.

> 
> 3. A patch adding the new MAB flag to BR_PORT_FLAGS_HW_OFFLOAD
> 
> 4. A patch allowing DSA core to propagate the MAB flag to device 
> drivers
> 
> [...]
> 
>> diff --git a/net/dsa/port.c b/net/dsa/port.c
>> index e4a0513816bb..eab32b7a945a 100644
>> --- a/net/dsa/port.c
>> +++ b/net/dsa/port.c
>> @@ -304,7 +304,7 @@ static int dsa_port_inherit_brport_flags(struct 
>> dsa_port *dp,
>>  					 struct netlink_ext_ack *extack)
>>  {
>>  	const unsigned long mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
>> -				   BR_BCAST_FLOOD | BR_PORT_LOCKED;
>> +				   BR_BCAST_FLOOD;
> 
> Not sure how this is related to the patchset.
> 
>>  	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
>>  	int flag, err;

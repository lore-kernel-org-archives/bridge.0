Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D6D460E67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4471360E43
MIME-Version: 1.0
Date: Fri, 21 Oct 2022 15:16:21 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221021112216.6bw6sjrieh2znlti@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221018165619.134535-11-netdev@kapio-technology.com>
 <20221020132538.reirrskemcjwih2m@skbuf>
 <2565c09bb95d69142522c3c3bcaa599e@kapio-technology.com>
 <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
Message-ID: <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
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

On 2022-10-21 13:22, Vladimir Oltean wrote:
> On Fri, Oct 21, 2022 at 08:47:42AM +0200, netdev@kapio-technology.com 
> wrote:
>> On 2022-10-21 00:57, Vladimir Oltean wrote:
>> > On Thu, Oct 20, 2022 at 10:20:50PM +0200, netdev@kapio-technology.com
>> > wrote:
>> > > In general locked ports block traffic from a host based on if there
>> > > is a
>> > > FDB entry or not. In the non-offloaded case, there is only CPU
>> > > assisted
>> > > learning, so the normal learning mechanism has to be disabled as any
>> > > learned entry will open the port for the learned MAC,vlan.
>> >
>> > Does it have to be that way? Why can't BR_LEARNING on a BR_PORT_LOCKED
>> > cause the learned FDB entries to have BR_FDB_LOCKED, and everything
>> > would be ok in that case (the port will not be opened for the learned
>> > MAC/VLAN)?
>> 
>> I suppose you are right that basing it solely on BR_FDB_LOCKED is 
>> possible.
>> 
>> The question is then maybe if the common case where you don't need 
>> learned
>> entries for the scheme to work, e.g. with EAPOL link local packets, 
>> requires
>> less CPU load to work and is cleaner than if using BR_FDB_LOCKED 
>> entries?
> 
> I suppose the real question is what does the bridge currently do with
> BR_LEARNING + BR_PORT_LOCKED, and if that is sane and useful in any 
> case?
> It isn't a configuration that's rejected, for sure. The configuration
> could be rejected via a bug fix patch, then in net-next it could be 
> made
> to learn these addresses with the BR_FDB_LOCKED flag.
> 
> To your question regarding the common case (no MAB): that can be 
> supported
> just fine when BR_LEARNING is off and BR_PORT_LOCKED is on, no?
> No BR_FDB_LOCKED entries will be learned.

As it is now in the bridge, the locked port part is handled before 
learning
in the ingress data path, so with BR_LEARNING and BR_PORT_LOCKED, I 
think it
will work as it does now except link local packages.

If your suggestion of BR_LEARNING causing BR_FDB_LOCKED on a locked 
port, I
guess it would be implemented under br_fdb_update() and BR_LEARNING +
BR_PORT_LOCKED would go together, forcing BR_LEARNING in this case, thus 
also
for all drivers?

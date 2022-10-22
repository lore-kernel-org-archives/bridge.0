Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77F074168D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F3554168C
MIME-Version: 1.0
Date: Sat, 22 Oct 2022 15:15:03 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221022120200.no5pl54bcfa3wcnd@skbuf>
References: <20221020225719.l5iw6vndmm7gvjo3@skbuf>
 <82d23b100b8d2c9e4647b8a134d5cbbf@kapio-technology.com>
 <20221021112216.6bw6sjrieh2znlti@skbuf>
 <7bfaae46b1913fe81654a4cd257d98b1@kapio-technology.com>
 <20221021163005.xljk2j3fkikr6uge@skbuf>
 <d1fb07de4b55d64f98425fe66156c4e4@kapio-technology.com>
 <20221021173014.oit3qmpkrsjwzbgu@skbuf>
 <b88e331e016ad3801f1bf1a0dec507f3@kapio-technology.com>
 <20221021181411.sv52q4yxr5r7urab@skbuf>
 <37dc7673fde2b8e166a5ed78431a2078@kapio-technology.com>
 <20221022120200.no5pl54bcfa3wcnd@skbuf>
Message-ID: <871cd2930adbed99d351da0864aee340@kapio-technology.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On 2022-10-22 14:02, Vladimir Oltean wrote:
> On Sat, Oct 22, 2022 at 09:24:56AM +0200, netdev@kapio-technology.com 
> wrote:
>> I will not say that you are not making sense as for the mv88e6xxx, as 
>> it
>> needs port association in all cases with BR_PORT_LOCKED, MAB or not, 
>> and
>> port association is turned on in the driver with learning turned on.
>> 
>> That said, there must be some resolution and agreement overall with 
>> this
>> issue to move on. Right now port association is turned on in the 
>> mv88e6xxx
>> driver when locking the port, thus setting learning off after locking 
>> will
>> break things.
> 
> This already needs to be treated as a bug and fixed on its own. Forget
> about MAB.
> 
> You're saying that when BR_LEARNING=on and BR_PORT_LOCKED=on, the
> mv88e6xxx driver works properly, but the software bridge is broken
> (learns from link-local multicast).
> 
> When BR_LEARNING=off and BR_PORT_LOCKED=on, the software bridge is not
> broken, but the mv88e6xxx driver is, because it requires the PAV
> configured properly.
> 
> And you're saying that I'm the one who suggests things should work
> differently in software mode vs offloaded mode?!

Well :-) To be specific, I am talking about how things work from a user
perspective, where I have kept to BR_LEARNING off before turning
BR_PORT_LOCKED on.

I admit to a weakness in that BR_LEARNING off after BR_PORT_LOCKED on is
a problem that from my perspective at this point would be a user error.

> 
> Why don't you
> (a) deny BR_LEARNING + BR_PORT_LOCKED in the bridge layer
> (b) fix the mv88e6xxx driver to always keep the assoc_vector set
>     properly for the port, if BR_LEARNING *or* BR_PORT_LOCKED is set?

(a) yes, I have thought that documentation could handle this, but maybe
     you are right, maybe it should be enforced...
(b) BR_PORT_LOCKED ensures now that the PAV is correctly set, so I have
     basically distinguished between learning and port association (which
     I know mechanically is the same in mv88e6xxx), but still I have
     adhered to learning off while port association is on for the port.

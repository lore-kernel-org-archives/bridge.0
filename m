Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1ea85ef2-0feb-dec0-ae25-68f4b42543b2@gmail.com>
References: <cover.1527173527.git.petrm@mellanox.com>
	<61962919-cf93-cd7b-f248-9dfee5c9529d@gmail.com>
	<1ea85ef2-0feb-dec0-ae25-68f4b42543b2@gmail.com>
Date: Fri, 25 May 2018 12:31:37 -0400
Message-ID: <87y3g7lms6.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 0/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>, Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Hi Florian,

Florian Fainelli <f.fainelli@gmail.com> writes:

> Andrew, Vivien, if the following hunks get applied are we possibly
> breaking mv88e6xxx? This is the use case that is really missing IMHO at
> the moment in DSA: we cannot control the VLAN membership and attributes
> of the CPU port(s), so either we make it always tagged in every VLAN
> (not great), or we introduce the ability to target the CPU port which is
> what Petr's patches + mine do.

Your change looks good to me. mv88e6xxx programs the DSA and CPU ports'
membership as "unmodified" (i.e. "as-is", which is a Marvell feature),
so that shouldn't change the current behavior.


Thanks,

        Vivien

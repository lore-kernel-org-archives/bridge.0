Return-Path: <wilco@baanhofman.nl>
Message-ID: <1369812543.6697.3.camel@localhost>
From: Wilco Baan Hofman <wilco@baanhofman.nl>
Date: Wed, 29 May 2013 09:29:03 +0200
In-Reply-To: <51A53977.1090106@powercraft.nl>
References: <51A53977.1090106@powercraft.nl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bond-mode 4 bridge-utils 3.x kernel not fully working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jelle de Jong <jelledejong@powercraft.nl>
Cc: bridge@lists.linux-foundation.org

On Wed, 2013-05-29 at 01:10 +0200, Jelle de Jong wrote:

> Traffic comes out the KVM quests but doesn?t come in. If I disable
> bonding everything just works again.
> 

> auto bond0
>   iface bond0 inet manual
>   slaves eth0 eth1
>   bond-mode 4
>   bond-miimon 100
>   pre-up /sbin/ifconfig bond0 mtu 9000

> auto eth0
>   iface eth0 inet manual
>   mtu 900

Does this one really say mtu 900 instead of 9000? 
Is your eth1 up? 
Did you try non-kvm traffic over the bonding interface?
Is the switch in LACP mode?

Regards,

Wilco Baan Hofman


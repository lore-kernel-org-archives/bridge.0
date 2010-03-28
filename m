Message-ID: <4BAF5034.5060100@pandora.be>
Date: Sun, 28 Mar 2010 14:48:52 +0200
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>	<4BABCF8A.3040701@free.fr>	<OFDD80C4DC.137F4F61-ONC12576F2.002B1EE4-C12576F2.002B7EA6@transmode.se>	<4BAD1B85.6020807@free.fr>	<OFC6D98D54.CA7D4A8D-ONC12576F2.007212B2-C12576F2.00725708@transmode.se>	<2e59e6971003261442g77365b55sa624fe184e5003ac@mail.gmail.com>	<OFCA30CFD8.BFEED34E-ONC12576F3.003AD4F7-C12576F3.003B8B77@transmode.se>
	<20100327201752.51b6f7ad@nehalam>
In-Reply-To: <20100327201752.51b6f7ad@nehalam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] IP address on physcial interface instead of bridge
	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@lists.linux-foundation.org, Joakim Tjernlund <joakim.tjernlund@transmode.se>

Stephen Hemminger schreef:
>
> If you read the network receive code path in the kernel, you
> will see that there is a special hook used. Basically,
>
>   if received_interface_is_part_of_bridge(incoming_interface)
>   then process_bridged_packet(packet)
>
> Then bridge looks at packet and decides whether it is local or forwarded.
> The problem is with your application if it wants to use eth0 directly.
>
>   
The ebtables brouting chain was designed to enable you to do this.

-- 
Bart De Schuymer
www.artinalgorithms.be


Message-ID: <4BABCF8A.3040701@free.fr>
Date: Thu, 25 Mar 2010 22:03:06 +0100
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <OFB9EFBBE7.11608167-ONC12576F1.005B0C79-C12576F1.005BBE51@transmode.se>	<2e59e6971003251003g34f45ccsf7feecbcb2d68cbf@mail.gmail.com>
	<OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
In-Reply-To: <OF55692ECA.4BA1B52C-ONC12576F1.006BA68C-C12576F1.007010C8@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] IP address on physcial interface instead of
	bridge	interface?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

Joakim Tjernlund wrote:
[...]
> 
> Sorry but I could not find that discussion but it doesn't sound as
> what I was after. Basically I want the eth0 I/F keeping its IP address
> and take over the roll of the br0 I/F when it has an IP address.

Can you please try to explain the reason why you would like the bridge members to have an IP, 
instead of the br0 interface ?

What is the expected result ? Until now, you described a solution (having an IP address on the 
bridge members), but not the real problem you are trying to solve.

Basically, a bridge is a level 2 link between the bridge members. An IP address is not required for 
the bridge to provide L2 connectivity between the members. But, if the host hosting the bridge need 
to be able to send/receive packets to/from bridge members, then it use the br0 interface. Using br0 
to send packets let the bridge decide on which members to forward each packets. Using br0 to receive 
packets allow you not to listen on every members at the same time. For this reason, it is normal to 
give an IP address to th br0 interface and to leave the bridge members without any IP address.

HTH

	Nicolas.

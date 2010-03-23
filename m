Message-ID: <4BA873B7.5020506@pandora.be>
Date: Tue, 23 Mar 2010 08:54:31 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28@EMBX02-HQ.jnpr.net>
In-Reply-To: <DBDEC20E6E29304D8AE5EAA493609B3556AE2C7F28@EMBX02-HQ.jnpr.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge and ip addresses on enslaved interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Shawn Delaney <sdelaney@juniper.net>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

Shawn Delaney schreef:
> In the documentation I've seen so far a bridge is created with no IP address for its enslaved interfaces and optionally with an IP address on the bridge interface. For example, I create a bridge like so:
>
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
>
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> ifconfig br0 10.0.0.10 netmask 255.255.0.0
>
>
> This works fine. However if I do the following:
>
> ifconfig eth0 10.0.0.10 netmask 255.255.0.0
> ifconfig eth1 10.1.0.10 netmask 255.255.0.0
> ifconfig br0 0.0.0.0
>
>   
Sounds like you want to make a brouter. You can use the ebtables broute
table for that. See:
http://ebtables.sourceforge.net/examples/basic.html#ex_brouter

cheers,
Bart


-- 
Bart De Schuymer
www.artinalgorithms.be


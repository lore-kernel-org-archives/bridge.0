Message-ID: <49B00385.1010401@superduper.net>
Date: Thu, 05 Mar 2009 08:53:25 -0800
From: Simon Barber <simon@superduper.net>
MIME-Version: 1.0
References: <giab80caq6.fsf@karga.hank.lab>
In-Reply-To: <giab80caq6.fsf@karga.hank.lab>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] IP address on bridged interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dirk Gouders <gouders@et.bocholt.fh-gelsenkirchen.de>
Cc: bridge@lists.linux-foundation.org

Normally it does not make sense to put any L3 protocol address on port 
interfaces - because incoming packets are diverted to the bridge 
interface before the L3 protocol is examined. This means the L3 protocol 
running on the port interface will never see any incoming packets.

There are a few rare circumstances where it makes sense to have IP 
addresses on the port interfaces - it can be done with the use of the 
ebtables BROUTE chain - this allows one to selectively pass frames to 
the L3 protocol decode on a port rather than passing them to the bridge 
interface. One situation where I have used this trick is on an NFS root 
mounted networking device. On kernel boot the kernel NFS code assigns an 
IP address directly to the ethernet port. Once my networking code starts 
it creates a bridge and puts the ethernet port into the bridge. This 
stops the NFS root mount from working, and the machine halts. The work 
around is to put an ebtables rule in place to allow the NFS root mount 
IP address to continue working.

Simon


Dirk Gouders wrote:
> Hello,
>
> I am currently playing with bridging to learn about various
> possibilities to setup a bridge to enable networking for KVM guests.
>
> I learned that I cannot use an IP address on one of the bridged
> interfaces but have to assign that IP address to the bridge interface if
> I want to use it to reach the bridge itself.
>
> The documentation I found does not say much about this subject and I am
> wondering whether there are situations when I can use IP addresses on
> bridged interfaces or if it absolutely makes no sense to have an IP
> address assigned to a bridged interface.
>
> Any explanation or pointers are very welcome.
>
> Dirk
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>   


Date: Mon, 12 Jul 2004 02:23:05 +1000
Message-ID: <20040711162304.GA5938@sutekh.progsoc.uts.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: Anand Kumria <wildfire@progsoc.uts.edu.au>
Subject: [Bridge] qemu networking
Reply-To: bridge@osdl.org, wildfire@progsoc.org
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

I'm in the process of trying to convert my vmware setup over to qemu and
I've run into some problems with the networking portion.

In case not everyone is familiar with how networking works under vmware,
I'll give a brief outline. Basically a module (vmnet) is loaded at boot
which creates a number of virtual switches. One of those (vmnet0) is
connected to a physical interface and later vmware process 'magically'
connect to the switch (i suspect via /dev/vmnet0 but I haven't checked)
and guest os are able to send/receive packets and participate fully.

qemu has the ability to use tap interfaces and the functionality of
vmnet seems to be covered by the bridging module (hence me asking here).
qemu when run will allocate a tap interface and run 
/etc/qemu-ifup $tapif to allow you to do any configuration.

In my case I have done the following prior to running qemu:

brctl addbr br0
brctl stp br0 off
brctl addif br0 eth0
ip link set br0 up

NOTE eth0's ip address is dynamically obtained (changes frequently)

My /etc/qemu-ifup script is:

brctl addif br0 $tapif
ip link set $tapif up

I found with just that configuration I could have either the qemu guest
os talking on the network (if $tapif is part of br0) or just my host (if
br0 only contains eth0).

The only way I found to get them both able to communicate at the same
time is using ebtables, I have done:

ebtables -t broute -A BROUTING -p ipv4 --ip-dst $eth0-ip -j DROP
ebtables -t broute -A BROUTING -p arp --arp-ip-dst $eth0-ip -j DROP

However that won't allow the qemu guest and my host to speak with each
other.

Questions
1. Is this right? It seems 'ugly' to have to configure up an additional
interface (br0) when vmware does some magic so that there isn't. Is
there any mechanism to attach a tap interface to another interface
(deviceless bridging?) -- that would appear to be what I want.

2. Is there any further configuration magic I can do with ebtables so
that the qemu guest and the host can speak to each other? 

3. Good mechanisms to support the fact that eth0 changes IP often? 

Thanks for reading this far, please let me know if think there is a
better place to raise these issues.

Regards,
Anand

-- 
 `` All actions take place in time by the interweaving of the 
 forces of Nature; but the man lost in selfish delusion thinks 
 that he himself is the actor.'' 
        Lord Krishna to Arjuna in _The Bhagavad Gita_

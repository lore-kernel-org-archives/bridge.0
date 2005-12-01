Message-ID: <a9a0929d0511301826j4be826fao@mail.gmail.com>
Date: Thu, 1 Dec 2005 12:56:18 +1030
From: Mark Zipp <mark.r.zipp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Multiple "br" interfaces for a single bridge ?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi,

We've been recently trying to use VRRP
(https://sourceforge.net/projects/vrrpd/) to provide redundancy for a
couple of servers. What we wanted to do was to have both servers be
VRRP backups for the other. For example :

Server A - eth0
VRRP Master IP - 10.0.0.1
VRRP Backup IP - 10.0.0.2

Server B - eth0
VRRP Master IP - 10.0.0.2
VRRP Bcakup IP - 10.0.0.1

We'd then put two A records in DNS for the single hostname, and then
rely DNS round robin to perform basic load balancing between the
servers. If one of the servers fails, then the other would then take
over both of the VRRP Master IP addresses. This wouldn't be a perfect
fail over as any existing TCP sessions would die, however it is enough
availability for our requirements.

One problem we have is that, due to the way VRRP has to interact with
kernel ARP, the vrrpd software changes the assigned MAC addresses on
the interfaces it has been configured to use. Since the above scenario
would have two VRRP groups, resulting in two different MAC addresses,
we can't run two instances of VRRP as above using the same ethernet
interface.

One idea we had was to create a bridge on each server, add eth0 and
then a couple of dummy interfaces into the bridge, and then have each
VRRP instance use the a separate dummy interfaces. This would then
allow the dummy interfaces to have their MAC address changed, and
would then allow us to run multiple instances of VRRP on the hosts.

Unfortunately when we tried this, we found that because the dummy
interfaces become "pure" layer 2 interfaces when they are added to a
bridge, we can't refer to them with VRRP, as they won't talk IP - only
the bridge "brX" interface for a bridge will. Of course, there is only
one of them for a bridge, so again we're limited to one VRRP instance
on the server. Although we didn't expect it to work, we did try
creating two bridges and assigning the single eth0 interface to both
them. That didn't work.

Is there a way to somehow create multiple, separate IP interfaces for
a single bridge ?

The alternative way we were able to get something to work was to use
VLAN trunk interfaces, as they're IP capable, and are considered
separate interfaces by VRRP. The drawback was that we'd then have to
run VLAN trunks into the servers, and also have to have the VRRP
instances running on different IP subnets. That's certainly an option,
it was just a bit too complex for what we want to achieve.

If anybody has any suggestions as to how else we might achieve this,
I'm all ears.

Thanks,
Mark.

P.S., please CC me as I'm not subscribed to the list.


From: "Paul Congdon \(UC Davis\)" <ptcongdon@ucdavis.edu>
References: <mailman.17.1244798274.30314.bridge@lists.linux-foundation.org>
In-Reply-To: <mailman.17.1244798274.30314.bridge@lists.linux-foundation.org>
Date: Fri, 12 Jun 2009 02:53:43 -0700
Message-ID: <000c01c9eb43$ad1ee8b0$075cba10$@edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Bridge] RFC: Simple Private VLAN impl. (Paul Congdon)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

> 
> In the virtualization case, I think it's actually easier: do it via
> MAC addresses instead of interfaces.  In this case, since you're
> creating the virtual environments, you'll know the MAC address that
> gets generated for each VE.
> 
> 1) Set your policy to deny.
> 2) Permit all frames destined to/from the promiscuous MACs.
> 3) Permit all broadcast frames to the promiscuous MACs.
> 
> That takes care of the "isolated" use case.  If you need to support
> the "community" case:
> 4) Add pairwise bidirectional rules to permit communications between
> each MAC in a community.
> 
> Why is this easier?  Since you know the MACs of the VEs, you have a
> trivial way of identifying the rules associated with a VE.  This way,
> you know what rules to spin up and remove during the turnup or
> disabling of a VE.  Moreover, since all of the rules permit specific
> traffic, the order doesn't even matter.
> 

Ross certainly has a point.  I believe there is perhaps yet
another better way to handle this scenario.  It is called 
VEPA = Virtual Ethernet Port Aggregation.  It is definitely 
easier than PVLANs for VMs and there are no additional ebtables
rules required. 

A patch should be coming for this later today or tomorrow.  See:

http://www.ieee802.org/1/files/public/docs2009/new-hudson-vepa_seminar-20090
514d.pdf

for details.

Paul



Date: Thu, 14 Sep 2006 17:21:43 -0400
From: Andy Gospodarek <gospo@redhat.com>
Message-ID: <20060914212142.GB12665@gospo.rdu.redhat.com>
References: <OF1AE42FF9.06C5D926-ON852571E7.005804CC-852571E7.0057EE7E@ieee.org>
	<45076B88.80104@bristyle.com>
	<6.0.1.1.2.20060913075410.04133280@mail.expressoweb.co.uk>
	<45088D29.30501@bristyle.com>
	<20060914100619.76cb1828@localhost.localdomain>
	<6.0.1.1.2.20060914174624.05055480@mail.expressoweb.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.0.1.1.2.20060914174624.05055480@mail.expressoweb.co.uk>
Subject: Re: [Bridge] 802.1D/Linux STP issue
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tony Jeffree <tony@jeffree.co.uk>
Cc: bridge@osdl.org, netdev@vger.kernel.org, Brian Braunstein <brian@bristyle.com>, mick_seaman@ieee.org, Stephen Hemminger <shemminger@osdl.org>, Rajesh Mishra <rajesh_mish@yahoo.com>

On Thu, Sep 14, 2006 at 05:51:50PM +0100, Tony Jeffree wrote:
> Steve/Brian -
> 
> You've probably seen Mick Seaman's comments on this by now - as he points 
> out in his email, tinkering with existing STP implementations is not likely 
> to be a rewarding exercise and I would encourage you not to go there.
> 
> I would suggest that it would be a much more valuable exercise for the 
> Linux community to replace the existing STP support with an implementation 
> of RSTP.
> 

While we are at it can we rip it out of the kernel and develop a
user-space daemon that does it instead?  Setting the spanning-tree state
of a port could be done with a simple ioctl (well not too simple because
it would be good to support multiple STP instances so someone could
code up 802.1w support and the kernel interface would already be there).

Thoughts?



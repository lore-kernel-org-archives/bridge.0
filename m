Date: Mon, 18 Aug 2003 11:36:54 -0600
From: Sean Reifschneider <jafo@tummy.com>
Subject: Re: [Bridge] Bridging with ethertap causing kernel oops
Message-ID: <20030818173654.GN12512@tummy.com>
References: <20030817095157.GD12512@tummy.com> <20030818091235.6189d4d8.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818091235.6189d4d8.shemminger@osdl.org>
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

On Mon, Aug 18, 2003 at 09:12:35AM -0700, Stephen Hemminger wrote:
>Good, it is hard to get accurate data with vendor patched kernels.

Something was whacked with my 2.4.21 install and it wouldn't talk on the
network.  I was going to be using this for a project, but have decided
to use a routed network because of the problems with bridging.  I'll see
about getting something set up to test with again in the next couple of
days.

>Are you running with STP turned on?

Yes.  I won't have any loops in the network, I guess I could shut it off
if you thought it would help.

>Also, could you try with 2.6.0-test3 to see if it is something that
>has already been covered by the 2.6 bug fixing?

Ok, I can try that as well.

Thanks,
Sean
-- 
 With Microsoft you get Windows...  Linux gives you the whole house.
Sean Reifschneider, Member of Technical Staff <jafo@tummy.com>
tummy.com, ltd. - Linux Consulting since 1995.  Qmail, Python, SysAdmin
      Back off man. I'm a scientist.   http://HackingSociety.org/

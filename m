Subject: Re: [Bridge] Unexpected bridge behavior (Bug? You decide.)
References: <E1CssQO-0006qt-00@m5.risacher.org>
	<20050124120440.4b792108@dxpl.pdx.osdl.net>
From: Daniel Risacher <magnus@alum.mit.edu>
Date: Tue, 25 Jan 2005 23:31:05 -0500
In-Reply-To: <20050124120440.4b792108@dxpl.pdx.osdl.net> (Stephen
	Hemminger's message of "Mon, 24 Jan 2005 12:04:40 -0800")
Message-ID: <87y8egn75i.fsf@m5.risacher.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

>>>>> "Stephen" == Stephen Hemminger <shemminger@osdl.org> writes:

    Stephen> On Sun, 23 Jan 2005 19:49:48 -0500
    Stephen> Daniel Risacher <magnus@alum.mit.edu> wrote:

    >> While using the linux bridge module in 2.6.10, the kernel seems
    >> to munge the source IP address of broadcast UDP packets if they
    >> come from "0.0.0.1", and sticks on an address of the linux
    >> host.

    Stephen> That seems real surprising.

Agreed!    

    >> I humbly submit that re-writing the source address of packets
    >> is not proper behavior for a bridge, even if those source
    >> addresses are not traditionally valid.

    Stephen> Are you running bridging with filtering (ebtables) or
    Stephen> just pure bridging.  The bridge code itself never looks
    Stephen> at IP portion of the packet at all!

When I originally saw the problem, I did not have ebtables loaded.  I
since loaded it as a module and see no change.  I do have iptables
loaded, and had a MASQUERADE rule in POSTROUTE chain of the nat table.
Thinking this might be related, I deleted this rule and turned off
ip_forward; no change.

I removed the ipt_MASQUERADE module; no change.  I removed the
iptable_nat module; eureka!  Even when I had no rules in the nat
table, the iptable_nat module was modifying my source addresses.

    >> [SNIP] removed problem description, see original article at :
    >> http://lists.osdl.org/pipermail/bridge/2005-January/000802.html

    Stephen> [SNIP] removed other troubleshooting questions (and the
    Stephen> answers I was composing).

That solves my specific problem, but leads me to ponder if there's not
a bug lurking in the iptable_nat module.

I had similar problems with locally-generated UDP a few months ago: it
seemed like the kernel slapped on some source address that was
different from address of the bound socket.  As it turns out, this
problem also goes away if I remove the iptable_nat module.

-- 
     "The blues are multicolored."   -- Dave Lambert

Daniel Risacher                      magnus@alum.mit.edu

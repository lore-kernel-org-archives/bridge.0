Message-ID: <20040811190252.60995.qmail@web13903.mail.yahoo.com>
Date: Wed, 11 Aug 2004 12:02:52 -0700 (PDT)
From: Scott MacKay <scottmackay@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] RE: IPv6 + ip6tables packet bridging?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Currently, I would need to focus on 2.4.x, a 2.6 shift
only if I have time later on.  In the
ebtables-brnf-5_vs_2.4.25.diff patch, I do see a
section in br_nf_ptr_routing, ipv4_sabotage_out which
use a variable brnf_call_iptables, but I am not
familiar enough with the code know which sections
would need replicating for IPv6.
Has anyone started any work on IPv6 packet passing to
iptables?
-Scott

--- Bart De Schuymer <bdschuym@pandora.be> wrote:

> On Tuesday 10 August 2004 19:42, Scott MacKay wrote:
> > Hiyas,
> >    Is there a patch for the 2.4.x series to do
> > ip6tables bridging of IPv6 packets?  I was unable
> to
> > go to 2.6 due to issues with large packets so
> still
> > living in 2.4 land.  If there are no patches, any
> > ideas on what gets patched in IPv4 to allow this
> > bridging?
> 
> In 2.6 ip6tables doesn't see bridged IPv6 packets
> either. It should be easy to 
> add, though.
> 
> cheers,
> Bart
> 


		
__________________________________
Do you Yahoo!?
Y! Messenger - Communicate in real time. Download now. 
http://messenger.yahoo.com

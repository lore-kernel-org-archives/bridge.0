Message-ID: <4063965A.103@tuxdriver.com>
Date: Thu, 25 Mar 2004 21:32:58 -0500
From: "John W. Linville" <linville@tuxdriver.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridging vlans...
References: <011a01c412d3$f141fe90$f80210ac@djc.state.id.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeremy Jones <jjones@djc.state.id.us>
Cc: bridge@lists.osdl.org

Again, I'm no expert.  I hope someone will correct me if I'm wrong, blah 
blah blah...

To start, I think you should be using ebtables rather than iptables.  As 
I understand things, the ebtables stuff works at Layer-2.

I guess your purpose is to log untagged packets?  Are packets belonging 
to VLAN interfaces visible to the parent interface? (It seems intuitive 
that they would not be, but I really don't know.)  If not, then 
something like what you propose below should work (given ebtables 
instead of iptables).  If the VLAN packets ARE visible on the parent 
interface, then you will need to do some additional checking to make 
sure that the frames are actually untagged.  You may want to do this 
anyway so as to differentiate between untagged frames and frames tagged 
for an "unknown" VLAN.

Again, hth... :-)

John

Jeremy Jones wrote:
> Now, with iptables, under the first scenario (creating 2 vlan interfaces per
> physical interface, and bridging the vlan interfaces), can I safely DROP
> everything to, from, or through eth0 & eth1?  That is, assuming I don't want
> to forward any untagged frames.
> 
> So:
> 
> iptables -N only_tagged
> iptables -A only_tagged -j LOG --log-prefix " untagged? "
> iptables -A only_tagged -j DROP
> iptables -A INPUT -i eth0 -j only_tagged
> iptables -A INPUT -i eth1 -j only_tagged
> iptables -A OUTPUT -i eth0 -j only_tagged
> iptables -A OUTPUT -i eth1 -j only_tagged
> iptables -A FORWARD -i eth0 -j only_tagged
> iptables -A FORWARD -i eth1 -j only_tagged
> 
> Then do my more granular filtering on the vlan interfaces...
> 
> (guess this would be something to ask the vlan mailing list people -- but
> what the heck, this list isn't terribly busy anyway)
> 
> I imagine I'll have to come up with a fairly complex matrix of --physdev-in,
> --physdev-out, etc. combinations.  Yikes.
> 
> Jeremy
> 
> 
>>-----Original Message-----
>>From: bridge-bounces@lists.osdl.org 
>>[mailto:bridge-bounces@lists.osdl.org] On Behalf Of John W. Linville
>>Sent: Thursday, March 25, 2004 5:56 AM
>>To: Jeremy Jones
>>Cc: bridge@lists.osdl.org
>>Subject: Re: [Bridge] Bridging vlans...
>>
>>
>>Jeremy,
>>
>>I have no specific experience with a situation like yours.  But, that 
>>won't stop me from rendering an opinion... :-)
>>
>>I, too, would lean toward the first at least partly for the 
>>reason you 
>>describe.  But, you should also consider untagged frames and 
>>frames with 
>>other VLAN IDs.  The second configuration should bridge all frames 
>>(tagged or untagged), while the first will only be bridging 
>>frames with 
>>VLAN IDs of 4 or 51.  I'm not sure which is your desired 
>>behaviour, but 
>>I suspect it is the first configuration which you should prefer.
>>
>>Hth...
>>
>>John
>>-- 
> 
> 
> 
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge


